//
//  ContainerViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 14/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var newLetterButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newLetterButtonOutlet.setupShadow(color: UIColor(rgb: 0x756892), opacity: 0.5, offset: .zero, radius: 14)
        checkUser()
    }
    
    func checkUser() {
        if UserDefaults.standard.string(forKey: Constants.USER_UUID) == nil {
            self.register()
        }
    }
    
    func register() {
        let uuid = UUID().uuidString
        UserRequest().signUp(uuid: uuid) { (success, error) in
            if let _ = success {
                UserDefaults.standard.set(uuid, forKey: Constants.USER_UUID)
            }
        }
    }
    
    @IBAction func didTapCreateLetter(_ sender: Any) {
        //TODO: Animate
//        let destinationVC = EditLetterViewController()
//        destinationVC.isNew = true
//        self.performSegue(withIdentifier: "presentEditLetter", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "presentEditLetter") {
            let vc = segue.destination as! EditLetterViewController
            vc.viewState = .new
        }
    }

}
