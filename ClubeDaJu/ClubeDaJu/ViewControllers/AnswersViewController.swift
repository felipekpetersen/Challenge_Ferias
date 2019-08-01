//
//  AnswersViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 15/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit
import MessageUI

class AnswersViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkView: UIView!
    
    let answerCell = "AnswerTableViewCell"
    var letter: Letters?
    var sorted = [Answers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupViewTaps()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let letter = letter {
            LetterSingleton.shared.setAllAnswersForRead(letter: letter)
        }
    }
    
    //receber filtradas
    func filterLetter() {
        sorted = letter?.answer?.allObjects as! [Answers]
        sorted.sort{ $0.isNewAnswer && !$1.isNewAnswer }
    }
    
    //MARK:- Setups
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: answerCell, bundle: nil), forCellReuseIdentifier: answerCell)
    }
    
    func setupViewTaps() {
        let checkTap = UITapGestureRecognizer(target: self, action: #selector(didTapCheck))
        self.checkView.addGestureRecognizer(checkTap)
    }
    
    @objc func didTapCheck() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mail
    func createEmail(letterId: String, answerId: String) -> MFMailComposeViewController {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients(["br.clube.ju@gmail.com"])
        composeVC.setSubject("Denuncia da carta de número \(letterId), resposta de número \(answerId)")
        composeVC.setMessageBody("<p>Clube da Ju, acredito q esta carta viola as politicas do aplicativo. Vocês poderiam dar uma olhada para mim?<p><br><p>Obs: É essencial deixar o assunto da mensagem como esta para essa denuncia ser processada.<p>", isHTML: true)
        // Present the view controller modally.
        return composeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension AnswersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.letter?.answer?.count ?? 0
//        return sorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: answerCell, for: indexPath) as! AnswerTableViewCell
        if let answers = self.letter?.answer?.allObjects {
            cell.setup(answer: (answers as! [Answers])[indexPath.row])
            cell.delegate = self
        }
        return cell
    }
}


extension AnswersViewController: AnswerTableViewCellDelegate {
    func didTapDots(answerId: String) {
        self.present(self.createEmail(letterId: self.letter?.letterId ?? "", answerId: answerId), animated: true)
    }
    
    
}
