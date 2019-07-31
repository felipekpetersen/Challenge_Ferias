//
//  ReadLetterViewController.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 17/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

enum ReadLetterViewControllerState {
    case read
    case answer
}

class ReadLetterViewController: UIViewController {
    
    //MARK:- Navigation
    @IBOutlet weak var backgroundTopView: UIView!
    @IBOutlet weak var degradeImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sendLetterView: UIView!
    @IBOutlet weak var checkView: UIView!
    
    //MARK:-Letter
    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var letterScrollView: UIScrollView!
    @IBOutlet weak var titleLetterTextView: UITextView!
    @IBOutlet weak var contentLetterTextView: UITextView!
    @IBOutlet weak var letterBottomConstraint: NSLayoutConstraint!
    
    //MARK:-Answer
    @IBOutlet weak var answerScrollView: UIScrollView!
    @IBOutlet weak var answerTextView: UITextView!
    @IBOutlet weak var showLetterButton: UIButton!
    @IBOutlet weak var arrowImageView: UIImageView!
    
    //MARK:- answerButton
    @IBOutlet weak var answerButtonView: RoundedView!
    
    var viewState: ReadLetterViewControllerState = .read
    lazy var viewTopHeight = self.view.frame.height - self.backgroundTopView.frame.height - 45
    var isShowingLetter = false
    var hasAnswer = false
    var receivedLetter: LetterCodable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoScrollWhenKeyboardShowsUp()
        self.setupView(for: viewState)
        self.checkContent()
        self.viewTaps()
    }
    
    // MARK:- Scroll View Content Inset
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        answerScrollView.contentInset = inset
    }
    
    func setupView(for state: ReadLetterViewControllerState) {
        self.titleLabel.text = self.receivedLetter?.title
        self.contentLetterTextView.text = self.receivedLetter?.content
        
        
        self.viewState = state
        switch viewState {
        case .read:
            letterBottomConstraint.constant = 0
            self.titleLabel.text = "Apenas Leitura"
            self.titleLabel.textColor = UIColor(rgb: 0x8F8F8F)
            self.cancelButton.isHidden = true
            self.sendLetterView.isHidden = true
            self.checkView.isHidden = false
            self.degradeImageView.isHidden = false
            self.backgroundTopView.alpha = 0
            self.answerButtonView.isHidden = false
            self.answerButtonView.alpha = 1
            self.titleLetterTextView.textColor = UIColor(rgb: 0x404040)
            self.contentLetterTextView.textColor = UIColor(rgb: 0x404040)
        default:
            UIView.animate(withDuration: 1) {
                self.letterBottomConstraint.constant = self.viewTopHeight
                self.backgroundTopView.alpha = 1
                self.answerButtonView.alpha = 0
                self.view.layoutIfNeeded()
            }
            self.titleLabel.text = "Editar Responder"
            self.answerTextView.text = "Escreva uma resposta para esta carta!"
            self.answerTextView.textColor = UIColor(rgb: 0xCACACA)
            self.answerTextView.delegate = self
            self.titleLabel.textColor = .white
            self.cancelButton.isHidden = false
            self.sendLetterView.isHidden = false
            self.checkView.isHidden = true
            self.degradeImageView.isHidden = true
            self.answerButtonView.isHidden = true
            self.titleLetterTextView.textColor = UIColor(rgb: 0x8F8F8F)
            self.contentLetterTextView.textColor = UIColor(rgb: 0x8F8F8F)
        }
    }
    
    func checkContent() {
        if titleLetterTextView.text == nil || titleLetterTextView.text == "" {
            self.titleLetterTextView.text = "Sem Título"
            self.titleLetterTextView.textColor = UIColor(rgb: 0x8F8F8F)
        }
        if contentLetterTextView.text == nil || contentLetterTextView.text == "" {
            self.contentLetterTextView.text = "Sem Conteúdo"
            self.contentLetterTextView.textColor = UIColor(rgb: 0x8F8F8F)
        }
    }
    
    func viewTaps() {
        let answerTap = UITapGestureRecognizer(target: self, action: #selector(didTapAnswer))
        let checkTap = UITapGestureRecognizer(target: self, action: #selector(didTapCheck))
        let sendTap = UITapGestureRecognizer(target: self, action: #selector(didTapSend))
        
        self.answerButtonView.addGestureRecognizer(answerTap)
        self.checkView.addGestureRecognizer(checkTap)
        self.sendLetterView.addGestureRecognizer(sendTap)
    }
    
    @objc func didTapAnswer() {
        self.setupView(for: .answer)
    }
    
    @objc func didTapCheck() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapSend() {
        if self.answerTextView.text != nil && self.answerTextView.text != "" && hasAnswer{
            let alert = UIAlertController(title: "Atenção", message: "Deseja enviar esta resposta?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sim!", style: .default, handler: { action in
                
                var answer = AnswerCodable()
                answer.answerId = UUID().uuidString
                answer.content = self.answerTextView.text
                answer.isNewAnswer = true
                self.showSpinner(onView: self.view)
                LetterSingleton.shared.sendAnswer(userId: self.receivedLetter?.ownerUuid ?? "", letterId: self.receivedLetter?.letterId ?? "", answer: answer, success: {
                    self.removeSpinner()
                    self.dismiss(animated: true, completion: nil)
                }, fail: {
                    self.removeSpinner()
                })
                
                alert.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Não", style: .destructive, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Escreva uma resposta", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapShowLetter(_ sender: Any) {
        if isShowingLetter {
            self.letterBottomConstraint.constant = self.viewTopHeight
            self.showLetterButton.setTitle("Mostrar Carta", for: .normal)
        } else {
            self.letterBottomConstraint.constant = self.viewTopHeight/2
            self.showLetterButton.setTitle("Esconder", for: .normal)
        }
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }) { (complete) in
            self.isShowingLetter = !self.isShowingLetter

        }
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.setupView(for: .read)
    }
    
    
}

extension ReadLetterViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == answerTextView {
            if answerTextView.textColor == UIColor(rgb: 0xCACACA) {
                self.answerTextView.text = ""
                self.answerTextView.textColor = UIColor(rgb: 0x404040)
                self.hasAnswer = true
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if answerTextView.text == nil || answerTextView.text == "" {
            self.answerTextView.text = "Escreva uma resposta para esta carta!"
            self.answerTextView.textColor = UIColor(rgb: 0xCACACA)
            self.hasAnswer = false
        }
    }
}
