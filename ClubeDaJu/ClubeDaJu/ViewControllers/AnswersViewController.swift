//
//  AnswersViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 15/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class AnswersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkView: UIView!
    
    let answerCell = "AnswerTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupViewTaps()
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
}

extension AnswersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: answerCell, for: indexPath) as! AnswerTableViewCell
        return cell
    }
}
