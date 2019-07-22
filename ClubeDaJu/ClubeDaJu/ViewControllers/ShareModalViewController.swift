//
//  ShareModalViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 20/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

protocol ShareModalViewControllerDelegate {
    func didTapShare(id: String?)
    func didTapDontShare()
}

class ShareModalViewController: UIViewController {

    @IBOutlet weak var sendView: RoundedView!
    
    var delegate: ShareModalViewControllerDelegate?
    var letterId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewTaps()
    }
    
    func viewTaps() {
        let sendTap = UITapGestureRecognizer(target: self, action: #selector(didTapShare))
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        self.sendView.addGestureRecognizer(sendTap)
        self.view.addGestureRecognizer(dismissTap)
    }
    
    @objc func didTapShare() {
        self.delegate?.didTapShare(id: self.letterId)
        self.dismiss(animated: true, completion: nil)
        print("send")
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapDontSend(_ sender: Any) {
        self.delegate?.didTapDontShare()
        self.dismiss(animated: true, completion: nil)
        print("dont send")
    }
    
}
