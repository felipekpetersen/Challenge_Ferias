//
//  LetterCodable.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 25/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

struct LetterCodable: Codable {
    
    var content: String?
    var createDate: String?
    var editDate: String?
    var hasNotification: Bool?
    var letterId: String?
    var isFavorite: Bool?
    var isShared: Bool?
    var title: String?
    var ownerUuid: String?
    var answers: [AnswerCodable]?
}

struct AnswerCodable: Codable {
    var answerId: String?
    var content: String?
    var isNewAnswer: Bool?
}

class InternLetter: NSObject {
    static func getLetters(userId: String) -> [LetterCodable] {
        var letters: [LetterCodable] = []
        do {
            let path = "https://br-clube-ju.herokuapp.com/api/getLetters/\(userId)/"
            
            let url = URL(string: path)
            
            let lettersData = try Data(contentsOf: url as! URL)
            
            letters = try JSONDecoder().decode([LetterCodable].self, from: lettersData)
            LetterSingleton.shared.saveLettersFromRemoteDataSource(letters: letters)
            return letters

        } catch {
            print("\(error.localizedDescription)")
        }
        return letters
    }
    
    static func getRandomLetters(complete: @escaping() -> ()) -> [LetterCodable] {
        var letters: [LetterCodable] = []
        do {
            let path = "https://br-clube-ju.herokuapp.com/api/getAllLetters/"
            
            let url = URL(string: path)
            
            let lettersData = try Data(contentsOf: url as! URL)
            
            letters = try JSONDecoder().decode([LetterCodable].self, from: lettersData)
            complete()
            return letters
            
        } catch {
            complete()
            print("\(error.localizedDescription)")
        }
        complete()
        return letters
    }
}


