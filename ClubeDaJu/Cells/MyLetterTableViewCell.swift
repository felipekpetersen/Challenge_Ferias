//
//  MyLetterTableViewCell.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 10/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

protocol MyLetterTableViewCellDelegate {
    func didTapFavorite(isFavorite: Bool)
    func didTapShare(isShare: Bool)
}

class MyLetterTableViewCell: UITableViewCell {
    
    var delegate: MyLetterTableViewCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var notificationView: RoundedView!
    @IBOutlet weak var numberNotificationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.descLabel.lineHeightMultiple = LINE_HEIGHT
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        self.delegate?.didTapFavorite(isFavorite: true)
    }
    
    @IBAction func didTapShare(_ sender: Any) {
        self.delegate?.didTapShare(isShare: true)
    }
    
}
