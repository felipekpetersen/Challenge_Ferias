//
//  MyLetterTableViewCell.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 10/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

protocol MyLetterTableViewCellDelegate {
    func didTapFavorite(isFavorite: Bool, id: String)
    func didTapShare(isShare: Bool, id: String)
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
    var id: String?
    var delegate: MyLetterTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
//        self.descLabel.lineHeightMultiple = LINE_HEIGHT

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
        self.id = letter.letterId
        self.setupFavoriteState()
        self.setupSharedState()
    }
    
    func setupFavoriteState() {
        if isFavorite ?? false {
            self.favoriteButtonOutlet.setBackgroundImage(UIImage(named: "favorite_selected"), for: .normal)
            self.favoriteButtonOutlet.setupShadow(color: UIColor(rgb: 0xF7DB76), opacity: 94, offset: .zero, radius: 8)
            self.favoriteButtonOutlet.layer.shadowOpacity = 1
            
        } else {
            self.favoriteButtonOutlet.setBackgroundImage(UIImage(named: "favorite_unselected"), for: .normal)
            self.favoriteButtonOutlet.layer.shadowOpacity = 0
        }
    }
    
    func setupSharedState() {
        if isShared ?? false {
            self.shareButtonOutlet.setBackgroundImage(UIImage(named: "share_selected"), for: .normal)
            self.shareButtonOutlet.setupShadow(color: UIColor(rgb: 0xA794D2), opacity: 77, offset: .zero, radius: 8)
            self.shareButtonOutlet.layer.shadowOpacity = 1
            
        } else {
            self.shareButtonOutlet.setBackgroundImage(UIImage(named: "share_unselected"), for: .normal)
            self.shareButtonOutlet.layer.shadowOpacity = 0
            
        }
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
//        if let id = id {
//            LetterSingleton.shared.updateFavorite(id: id)
//        }
//        self.isFavorite = !(self.isFavorite ?? true)
//        self.setupFavoriteState()
        self.delegate?.didTapFavorite(isFavorite: self.isFavorite ?? false, id: self.id ?? "")
    }
    
    @IBAction func didTapShare(_ sender: Any) {
//        if let id = id {
//            LetterSingleton.shared.updateShared(id: id)
//        }
        self.isShared = !(self.isShared ?? true)
//        self.setupSharedState()
        self.delegate?.didTapShare(isShare: self.isShared ?? false, id: self.id ?? "")
    }
    
}
