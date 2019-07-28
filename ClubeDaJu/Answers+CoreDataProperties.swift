//
//  Answers+CoreDataProperties.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 26/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//
//

import Foundation
import CoreData


extension Answers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answers> {
        return NSFetchRequest<Answers>(entityName: "Answers")
    }

    @NSManaged public var content: String?
    @NSManaged public var answerId: String?
    @NSManaged public var isNewAnswer: Bool
    @NSManaged public var letters: Letters?

}
