//
//  ReceivedLetterCollectionViewCell.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 11/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class ReceivedLetterCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var outsideView: RoundedView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var botConstraint: NSLayoutConstraint!
    
    var cellFrame: CGRect?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descLabel.lineHeightMultiple = LINE_HEIGHT
        let color = UIColor(rgb: 0xEEAE7B)
        self.descLabel.frame.height
        self.outsideView.setupShadow(color: color, opacity: 0.45, offset: .zero, radius: 16)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        var frameCorrection = self.cellFrame
//        let counter = self.descLabel.text?.count ?? 0 / 10
//        if (frameCorrection?.height ?? 0) - CGFloat(counter) > 50 {
//            frameCorrection = CGRect(x: frameCorrection?.origin.x ?? 0, y: frameCorrection?.origin.y ?? 0, width: frameCorrection?.width ?? 0, height: self.descLabel.frame.height + 60)
//        }
//        self.frame = self.cellFrame ?? CGRect(x: 0, y: 0, width: 0, height: 0)
//    }
    
    func setup(letter: LetterCodable) {
        self.titleLabel.text = letter.title
        self.descLabel.text = letter.content
    }

}
