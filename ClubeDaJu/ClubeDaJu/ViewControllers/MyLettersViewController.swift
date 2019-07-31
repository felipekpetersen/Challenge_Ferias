//
//  ViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 10/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit
import UserNotifications

class MyLettersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    let viewModel = MyLettersViewModel()
    let myLetterCell = "MyLetterTableViewCell"
    var selectedIndex: IndexPath?
    var letterSharedId: String?
    var cellHeights: [IndexPath : CGFloat] = [:]
    
    var letters = [LetterCodable]()
    var notification = NotificationModel(title: "Que tal escrever?", message:"Por que não vem escrever um pouco?", time: 10, badge: true, sound: true)

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.setupTableView()
//        self.letters = InternLetter.getLetters(userId: UserDefaults.standard.string(forKey: Constants.USER_UUID) ?? "")
//        createNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.loadData()
        self.loadDataSorted()
        self.setupTableView()
        self.letters = InternLetter.getLetters(userId: UserDefaults.standard.string(forKey: Constants.USER_UUID) ?? "")
        createNotification()
    }

    func loadDataSorted() {
        self.viewModel.fetchSorted()
        self.tableView.reloadData()
        self.checkEmpty()
        checkFirstLetter()
    }
    
    func loadData() {
        self.viewModel.fetch()
        self.tableView.reloadData()
        self.checkEmpty()
        checkFirstLetter()
    }
    
    func checkFirstLetter() {
        if self.viewModel.letters?.count == 1, UserDefaults.standard.string(forKey: Constants.IS_FIRST_LETTER) == nil  {
            performSegue(withIdentifier: "showCellSegue", sender: self)
        }
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: myLetterCell, bundle: nil), forCellReuseIdentifier: myLetterCell)
    }
    
    func checkEmpty() {
        if self.viewModel.letters?.isEmpty ?? true {
            self.emptyView.isHidden = false
        } else {
            self.emptyView.isHidden = true 
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EditLetterViewController {
            vc.createdLetter = self.viewModel.letters?[selectedIndex?.row ?? 0]
            vc.viewState = .text
        } else if let vc = segue.destination as? ShareModalViewController {
            vc.delegate = self
            vc.letterId = self.letterSharedId
        }
    }
    
    
    func createNotification() {
        notification = NotificationModel(title: "Como foi seu dia?", message:"Venha escrever sobre você!", time: 86400, badge: true, sound: true)
        let badgeNumber = UIApplication.shared.applicationIconBadgeNumber
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: self.notification.title!, arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: self.notification.message!, arguments: nil)
                content.sound = UNNotificationSound.default
                
                if self.notification.badge {
                    content.badge = badgeNumber + 1 as NSNumber
                } else {
                    content.badge = nil
                }
                
                if self.notification.sound {
                    content.sound = .default
                } else {
                    content.sound = nil
                }
                
                content.categoryIdentifier = NotificationType.Category.tutorial
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: self.notification.time, repeats: false)
                
                let request = UNNotificationRequest(identifier: "5seconds", content: content, trigger: trigger)
                
                let center = UNUserNotificationCenter.current()
                center.removeAllPendingNotificationRequests()
                center.add(request) { (error : Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
            } else {
                print("Impossível mandar notificação - permissão negada")
            }
        }
    }
}

extension MyLettersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: myLetterCell, for: indexPath) as! MyLetterTableViewCell
        cell.setupCell(letter: self.viewModel.getLetterForRow(index: indexPath.row))
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
//        destinationVC.createdLetter = self.viewModel.letters?[indexPath.row] ?? Letters()
        performSegue(withIdentifier: "presentEdit", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath] ?? 146
//        return 146
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
}

extension MyLettersViewController: MyLetterTableViewCellDelegate {
    func didTapFavorite(isFavorite: Bool, id: String) {
        LetterSingleton.shared.updateFavorite(id: id)
//        self.loadData()
        self.loadDataSorted()
    }
    
    func didTapShare(isShare: Bool, id: String) {
        if isShare {
            self.letterSharedId = id
            performSegue(withIdentifier: "showModalFromHome", sender: self)
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Deseja cancelar o envio da carta?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { action in
                // Deletar do backEnd
                self.showSpinner(onView: self.view)
                LetterSingleton.shared.deleteLetter(id: id, success: {
                    LetterSingleton.shared.updateShared(id: id)
                    self.removeSpinner()
//                    self.loadData()
                    self.loadDataSorted()
                }, fail: {
                    self.removeSpinner()
                })
//                self.loadData()
                self.loadDataSorted()
                alert.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Não", style: .default, handler: { action in
//                self.loadData()
                self.loadDataSorted()
//                LetterSingleton.shared.updateShared(id: id)
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension MyLettersViewController: ShareModalViewControllerDelegate {
    func didTapShare(id: String?) {
        if let id = id {
            LetterSingleton.shared.sendLetter(id: id, success: {
                LetterSingleton.shared.updateShared(id: id)
//                self.loadData()
                self.loadDataSorted()
            })
        }
    }
    
    func didTapDontShare() {
//        self.loadData()
        self.loadDataSorted()
    }
    
 
}
