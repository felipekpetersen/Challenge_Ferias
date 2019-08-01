//
//  AnswerTableViewCell.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 15/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

protocol AnswerTableViewCellDelegate {
    func didTapDots(answerId: String)
}

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dotsView: UIView!
    
    var delegate: AnswerTableViewCellDelegate?
    var answerId: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewTaps()
    }
    
    func viewTaps() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDots))
        self.dotsView.addGestureRecognizer(tap)
    }
    
    @objc func didTapDots() {
        if let answerId = answerId {
            delegate?.didTapDots(answerId: answerId)
        }
    }
    
    func setup(answer: Answers?) {
        self.contentLabel.text = answer?.content
        self.newLabel.isHidden = !(answer?.isNewAnswer ?? false)
        self.answerId = answer?.answerId
    }
}
