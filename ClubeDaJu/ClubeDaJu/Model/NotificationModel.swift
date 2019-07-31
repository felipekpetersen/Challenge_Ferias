//
//  NotificationModel.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 30/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation

struct NotificationType {
    
    struct Category {
        static let tutorial = "tutorial"
    }
    
    struct Action {
        static let repetir = "repetir"
        static let next = "next"
    }
    
}


class NotificationModel {
    var title: String?
    var message: String?
    var time: Double
    var badge: Bool
    var sound: Bool
    
    init(title: String?, message: String?, time: Double, badge: Bool, sound: Bool) {
        if title == nil || title == "" {
            self.title = "Sem titulo"
        } else {
            self.title = title
        }
        if message == nil || message == "" {
            self.message = "Sem mensagem"
        } else {
            self.message = message
        }
        self.time = time
        self.badge = badge
        self.sound = sound
    }
}
