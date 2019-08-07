//
//  RequestConstants.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 25/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation


struct RequestConstants {
    
    static let URL = "https://br-clube-ju.herokuapp.com/api/"
//    static let URL = "http://localhost:3000/api/"

    static let POST_SIGNUP = "\(RequestConstants.URL)signup"
    static let POST_TOKEN = "\(RequestConstants.URL)registerForPush"

    static let POST_ADDLETTER = "\(RequestConstants.URL)addLetter"
    static let POST_DELETELETTER = "\(RequestConstants.URL)deleteLetter"
    static let POST_UPDATELETTER = "\(RequestConstants.URL)updateLetter"
    static let POST_ADDANSWER = "\(RequestConstants.URL)addAnswer"
}
 

struct Constants {
    
    static let USER_UUID = "useruuid"
    static let IS_FIRST_LETTER = "isfirstletter"
    static let USER_TOKEN = "usertoken"
}
