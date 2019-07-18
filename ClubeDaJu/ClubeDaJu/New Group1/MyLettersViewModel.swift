//
//  MyLettersViewModel.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 18/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyLettersViewModel {
    
    var letters: [Letters]?
    var context: NSManagedObjectContext?
    var loadError: Error?
    
    func fetch() {
        (letters, loadError) = LetterSingleton.shared.fetch()
    }
    
    func getNumberOfRows() -> Int{
        return letters?.count ?? 0
    }
    
    func getLetterForRow(index: Int) -> Letters {
        return letters?[index] ?? Letters()
    }
}
