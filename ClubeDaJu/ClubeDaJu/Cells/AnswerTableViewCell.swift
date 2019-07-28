//
//  AnswerTableViewCell.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 15/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(answer: Answers?) {
        self.contentLabel.text = answer?.content
        self.newLabel.isHidden = !(answer?.isNewAnswer ?? false)
    }
}
