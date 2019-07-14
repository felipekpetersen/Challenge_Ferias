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
    }
    
}
