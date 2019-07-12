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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let color = UIColor(rgb: 0xEEAE7B)
        self.outsideView.setupShadow(color: color, opacity: 0.45, offset: .zero, radius: 16)
    }

}
