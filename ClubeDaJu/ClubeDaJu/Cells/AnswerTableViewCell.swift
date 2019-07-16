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
        contentLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet lorem id tempor vehicula. In nec quam vitae ligula pretium mollis et nec tellus. Vivamus molestie interdum eros quis fermentum. Sed orci nulla, volutpat eu lorem eu, volutpat vulputate enim. Etiam id magna id nisl ullamcorper vulputate ut eget nunc. Donec luctus magna at ex porta volutpat. Etiam sed velit vehicula, pellentesque ligula et, sagittis justo. Nam porttitor mi eget sem accumsan, eget auctor massa bibendum. Donec sodales gravida condimentum. Etiam laoreet eu urna non egestas. Nunc risus elit, ultrices a nibh sed, ultricies convallis libero. Mauris venenatis dolor eget lacus consequat, quis efficitur ante auctor. Nam sagittis, orci in efficitur congue, dolor felis iaculis nunc, ac dictum lect"
    }
}
