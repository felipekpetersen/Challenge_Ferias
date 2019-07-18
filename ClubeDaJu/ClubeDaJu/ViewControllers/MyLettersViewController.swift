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
    @IBOutlet weak var emptyView: UIView!
    
    let viewModel = MyLettersViewModel()
    let myLetterCell = "MyLetterTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadData()
    }
    
    func loadData() {
        self.viewModel.fetch()
        self.tableView.reloadData()
        self.checkEmpty()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = EditLetterViewController()
        destinationVC.viewState = .text
        destinationVC.createdLetter = self.viewModel.letters?[indexPath.row] ?? Letters()
        performSegue(withIdentifier: "presentEdit", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 146 
    }
}
