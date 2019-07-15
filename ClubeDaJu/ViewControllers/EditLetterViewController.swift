//
//  EditLetterViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 15/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

enum EditLetterViewControllerState {
    case new
    case text
}

class EditLetterViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dotsView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var checkView: UIView!
    
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var answersView: RoundedView!
    
    var viewState: EditLetterViewControllerState?
//    var letterModel!!!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupViewTaps()
        self.setupShadow()
        self.checkEmptyness()
    }
    
    //MARK:- Setups
    func setupView() {
        self.titleTextView.delegate = self
        self.contentTextView.delegate = self
        if let state = viewState {
            switch state {
            case .new:
                self.titleTextView.text = "Insira um Titulo"
                self.titleTextView.textColor = UIColor(rgb: 0xCACACA)
                self.contentTextView.text = "Conte sua história"
                self.contentTextView.textColor = UIColor(rgb: 0xCACACA)
            case .text:
                break
            }
        }
    }
    
    func setupViewTaps() {
        let endEditingTap = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        let dotsTap = UITapGestureRecognizer(target: self, action: #selector(didTapDots))
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(didTapShare))
        let checkTap = UITapGestureRecognizer(target: self, action: #selector(didTapCheck))
        let answersTap = UITapGestureRecognizer(target: self, action: #selector(didTapAnswers))
        
        self.view.addGestureRecognizer(endEditingTap)
        self.dotsView.addGestureRecognizer(dotsTap)
        self.shareView.addGestureRecognizer(shareTap)
        self.checkView.addGestureRecognizer(checkTap)
        self.answersView.addGestureRecognizer(answersTap)
    }
    
    func setupShadow() {
        self.answersView.setupShadow(color: UIColor(rgb: 0x756892), opacity: 0.54, offset: .zero, radius: 7)
    }
    
    func checkEmptyness() {
        if titleTextView.text == nil || titleTextView.text == "" {
            self.titleTextView.text = "Insira um Titulo"
            self.titleTextView.textColor = UIColor(rgb: 0xCACACA)
        }
        if contentTextView.text == nil || contentTextView.text == "" {
            self.contentTextView.text = "Conte sua história"
            self.contentTextView.textColor = UIColor(rgb: 0xCACACA)
        }
    }
    
    
    //MARK:- Taps
    @objc func didTapDismiss() {
        titleTextView.endEditing(true)
        contentTextView.endEditing(true)
    }
    
    @objc func didTapDots() {
        //TODO:- Mostrar apagar
    }
    
    @objc func didTapShare() {
        //TODO:- mostrar modal de share
    }
    
    @objc func didTapCheck() {
        //TODO:- Salvar texto
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapAnswers() {
        //TODO:- mover para respostas
    }
    
}

//MARK:- TextViewDelegate
extension EditLetterViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == titleTextView {
            if titleTextView.textColor == UIColor(rgb: 0xCACACA) {
                self.titleTextView.text = ""
                self.titleTextView.textColor = UIColor(rgb: 0x404040)
            }
        } else {
            if contentTextView.textColor == UIColor(rgb: 0xCACACA) {
                self.contentTextView.text = ""
                self.contentTextView.textColor = UIColor(rgb: 0x404040)
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        self.checkEmptyness()
    }
}
