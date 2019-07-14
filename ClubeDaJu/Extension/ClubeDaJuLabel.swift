//
//  ClubeDaJuLabel.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 13/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    @IBInspectable
    var lineHeightMultiple: CGFloat {
        set{
            
            //get our existing style or make a new one
            let paragraphStyle: NSMutableParagraphStyle
            if let existingStyle = attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: .none) as? NSParagraphStyle, let mutableCopy = existingStyle.mutableCopy() as? NSMutableParagraphStyle  {
                paragraphStyle = mutableCopy
            } else {
                paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 1.0
                paragraphStyle.alignment = self.textAlignment
            }
            paragraphStyle.lineHeightMultiple = newValue
            
            //set our text from existing text
            let attrString = NSMutableAttributedString()
            if let text = self.text {
                attrString.append( NSMutableAttributedString(string: text))
                attrString.addAttribute(NSAttributedString.Key.font, value: self.font, range: NSMakeRange(0, attrString.length))
            }
            else if let attributedText = self.attributedText {
                attrString.append( attributedText)
            }
            
            //add our attributes and set the new text
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
            self.attributedText = attrString
        }
        
        get {
            if let paragraphStyle = attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: .none) as? NSParagraphStyle {
                return paragraphStyle.lineHeightMultiple
            }
            return 0
        }
    }
}

