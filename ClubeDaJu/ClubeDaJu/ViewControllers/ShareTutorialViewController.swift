//
//  ShareTutorialViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 30/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class ShareTutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("no", forKey: Constants.IS_FIRST_LETTER)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOk(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
