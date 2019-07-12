//
//  ViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 10/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class MyLettersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let myLetterCell = "MyLetterTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UINib(nibName: myLetterCell, bundle: nil), forCellReuseIdentifier: myLetterCell)
    }
}

extension MyLettersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: myLetterCell, for: indexPath) as! MyLetterTableViewCell
        return cell
    }
    
    
}

