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
    @IBOutlet weak var shareImageView: UIImageView!
    @IBOutlet weak var checkView: UIView!
    
    @IBOutlet weak var saveLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var answersView: RoundedView!
    @IBOutlet weak var answerLabel: UILabel!
    
    var viewState: EditLetterViewControllerState?
    var createdLetter: Letters?
    
    override func viewDidLoad() {
        setupAutoScrollWhenKeyboardShowsUp()
        super.viewDidLoad()
        self.setupView()
        self.setupViewTaps()
        self.checkEmptyness()
    }
    
    // MARK:- Scroll View Content Inset
    override func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        scrollView.contentInset = inset
    }
    
    //MARK:- Setups
    func setupView() {
        self.titleTextView.delegate = self
        self.contentTextView.delegate = self
        if let state = viewState {
            switch state {
            //New: se o cara cria uma carta nova
            case .new:
                self.titleTextView.text = "Insira um Titulo"
                self.titleTextView.textColor = UIColor(rgb: 0xCACACA)
                self.contentTextView.text = "Conte sua história"
                self.contentTextView.textColor = UIColor(rgb: 0xCACACA)
                self.answersView.isHidden = true
                self.createdLetter = LetterSingleton.shared.create()
                self.dateLabel.text = self.createdLetter?.createDate
                //text: Editar uma carta ja existente
            case .text:
                self.titleTextView.text = self.createdLetter?.title
                self.contentTextView.text = self.createdLetter?.content
                if let id = self.createdLetter?.letterId {
                    LetterSingleton.shared.updateEditDate(id: id)
                    self.dateLabel.text = "\(self.createdLetter?.createDate ?? "Sem data") - \(self.createdLetter?.editDate ?? "Sem data")"
                }
            }
            setupAnswersButton()
        }
    }
    
    //Aparencia do botao, caso ele deva aparecer ou nao
    func setupAnswersButton() {
        if let isShared = self.createdLetter?.isShared{
            self.answersView.isHidden = !isShared
            self.shareImageView.image = UIImage(named: isShared ? "editor_share_selected" : "editor_share_unselected")
            if let hasNotification = self.createdLetter?.hasNotification {
                if hasNotification {
                    self.answerLabel.text = "Novas Respostas"
                    self.answersView.backgroundColor = UIColor(rgb: 0xFF847B)
                    self.answersView.setupShadow(color: UIColor(rgb: 0xFF847B), opacity: 0.54, offset: .zero, radius: 7)
                } else {
                    self.answerLabel.text = "Ver Respostas"
                    self.answersView.backgroundColor = UIColor(rgb: 0x756892)
                    self.answersView.setupShadow(color: UIColor(rgb: 0x756892), opacity: 0.54, offset: .zero, radius: 7)
                }
            }
        }
    }
    
    func setupViewTaps() {
        let endEditingTap = UITapGestureRecognizer(target: self, action: #selector(didTapDismiss))
        let dotsTap = UITapGestureRecognizer(target: self, action: #selector(didTapDots))
        let shareTap = UITapGestureRecognizer(target: self, action: #selector(didTapShareButton))
        let checkTap = UITapGestureRecognizer(target: self, action: #selector(didTapCheck))
        let answersTap = UITapGestureRecognizer(target: self, action: #selector(didTapAnswers))
        
        self.view.addGestureRecognizer(endEditingTap)
        self.dotsView.addGestureRecognizer(dotsTap)
        self.shareView.addGestureRecognizer(shareTap)
        self.checkView.addGestureRecognizer(checkTap)
        self.answersView.addGestureRecognizer(answersTap)
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
    //Dismiss do teclado quando tocar fora.
    @objc func didTapDismiss() {
        titleTextView.endEditing(true)
        contentTextView.endEditing(true)
    }
    
    //Aparece opcoes para deletar. Futuramente existira outras opcoes.
    @objc func didTapDots() {
        let optionMenu = UIAlertController(title: nil, message: "Escolha uma opção", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            if let id = self.createdLetter?.letterId {
                LetterSingleton.shared.deleteLetter(id: id)
            }
            self.dismiss(animated: true, completion: nil)
            })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @objc func didTapShareButton() {
        if !(self.createdLetter?.isShared ?? false) {
            performSegue(withIdentifier: "showModalFromEdit", sender: self)
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Deseja cancelar o envio da carta?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { action in
                //TODO: Deletar do backEnd
                if let id = self.createdLetter?.letterId {
                LetterSingleton.shared.deleteLetter(id: id, success: {
                    LetterSingleton.shared.updateShared(id: id)
                    self.setupAnswersButton()
                })
                }
                alert.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Não", style: .default, handler: { action in
                self.setupAnswersButton()
                //                LetterSingleton.shared.updateShared(id: id)
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Verifica se existe um texto, se sim, salva-o. caso contrario, pergunta se pode deletar.
    @objc func didTapCheck() {
        if titleTextView.text != "Insira um Titulo", contentTextView.text != "Conte sua história" {
            LetterSingleton.shared.updateText(id: self.createdLetter?.letterId ?? "", title: self.titleTextView.text, content: self.contentTextView.text)
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Atenção", message: "Uma carta precisa de um titulo e corpo para ser salvo! Deseja deletar a carta?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil)
                }))
            alert.addAction(UIAlertAction(title: "Deletar", style: .destructive, handler: { action in
                if let id = self.createdLetter?.letterId {
                    LetterSingleton.shared.deleteLetter(id: id)
                }
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //Abre tela de respostas para aquela carta
    @objc func didTapAnswers() {
        performSegue(withIdentifier: "answersSegue", sender: self)
        //TODO:- mover para respostas
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ShareModalViewController {
            vc.delegate = self
            vc.letterId = self.createdLetter?.letterId
        } else if let vc = segue.destination as? AnswersViewController {
            vc.letter = self.createdLetter
        }
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

extension EditLetterViewController: ShareModalViewControllerDelegate {
    func didTapShare(id: String?) {
        if let id = id {
            LetterSingleton.shared.sendLetter(id: id, success: {
                LetterSingleton.shared.updateShared(id: id)
                self.setupAnswersButton()
            })
        }
    }
    
    func didTapDontShare() {
        self.setupAnswersButton()
    }
    
    
}
