//
//  ReceivedLettersViewModel.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 27/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation

class ReceivedLettersViewModel {
    
    var letters = [LetterCodable]()
    
    func fetchLetters(complete: @escaping() -> ()) {
        self.letters = InternLetter.getRandomLetters(complete: {
            complete()
        })
    }
    
    func getNumberOfRows() -> Int {
        return self.letters.count
    }
    
    func getLetterForRow(index: Int) -> LetterCodable {
        return self.letters[index]
    }
}
