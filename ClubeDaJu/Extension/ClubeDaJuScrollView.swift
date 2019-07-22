//
//  ClubeDaJuScrollView.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 22/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

//    // MARK: - AutoScrollWhenKeyboardShowsUp
//    /**
//     Sobe a scrollview quando o teclado aparece. Normalmente utilizado em formulários
//     O TextField deve estar dentro de uma s@objc @objc crollView
//     Não se esqueça de dar override no setScrollViewContentInset e dar removeObservers() no viewDidDisappear
//     */
//
extension UIViewController {
    func setupAutoScrollWhenKeyboardShowsUp() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        self.view.addGestureRecognizer(tapGesture)
        addObservers()
    }
    
    @objc func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        setScrollViewContentInset(contentInset)
    }
    
    func keyboardWillHide(notification: Notification) {
        setScrollViewContentInset(UIEdgeInsets.zero)
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    //    // OVERRIDE IT!
    @objc func setScrollViewContentInset(_ inset: UIEdgeInsets) {
        
    }
}
