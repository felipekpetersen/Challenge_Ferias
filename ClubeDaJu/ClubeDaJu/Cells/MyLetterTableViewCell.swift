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

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var notificationView: RoundedView!
    @IBOutlet weak var numberNotificationLabel: UILabel!
    @IBOutlet weak var mailNotificationView: RoundedView!
    @IBOutlet weak var favoriteButtonOutlet: UIButton!
    @IBOutlet weak var shareButtonOutlet: UIButton!
    
    var isFavorite: Bool?
    var isShared: Bool?
    var delegate: MyLetterTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.descLabel.lineHeightMultiple = LINE_HEIGHT

    }
    
    func setupCell(letter: Letters) {
        if letter.title == nil || letter.title == "" {
            titleLabel.text = "Sem titulo"
        } else {
            self.titleLabel.text = letter.title
        }
        if letter.content == nil || letter.content == "" {
            descLabel.text = "Sem texto"
        } else {
            self.descLabel.text = letter.content
        }
        
        self.mailNotificationView.isHidden = !(letter.hasNotification)
        self.isShared = letter.isShared
        self.isFavorite = letter.isFavorite
        
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        if isFavorite ?? false {
            self.isFavorite = false
            self.favoriteButtonOutlet.setBackgroundImage(UIImage(named: "favorite_unselected"), for: .normal)
            self.favoriteButtonOutlet.layer.shadowOpacity = 0
            
        } else {
            self.isFavorite = true
            self.favoriteButtonOutlet.setBackgroundImage(UIImage(named: "favorite_selected"), for: .normal)
            self.favoriteButtonOutlet.setupShadow(color: UIColor(rgb: 0xF7DB76), opacity: 94, offset: .zero, radius: 8)
            self.favoriteButtonOutlet.layer.shadowOpacity = 1
        }
        self.delegate?.didTapFavorite(isFavorite: self.isFavorite ?? false)
    }
    
    @IBAction func didTapShare(_ sender: Any) {
        if isShared ?? false {
            self.isShared = false
            self.shareButtonOutlet.setBackgroundImage(UIImage(named: "share_unselected"), for: .normal)
            self.shareButtonOutlet.layer.shadowOpacity = 0
           
        } else {
            self.isShared = true
            self.shareButtonOutlet.setBackgroundImage(UIImage(named: "share_selected"), for: .normal)
            self.shareButtonOutlet.setupShadow(color: UIColor(rgb: 0xA794D2), opacity: 77, offset: .zero, radius: 8)
            self.shareButtonOutlet.layer.shadowOpacity = 1
        }
        self.delegate?.didTapShare(isShare: self.isShared ?? false)
    }
    
}
