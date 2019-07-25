//
//  Letters+CoreDataProperties.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 25/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//
//

import Foundation
import CoreData


extension Letters {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Letters> {
        return NSFetchRequest<Letters>(entityName: "Letters")
    }

    @NSManaged public var content: String?
    @NSManaged public var createDate: String?
    @NSManaged public var editDate: String?
    @NSManaged public var hasNotification: Bool
    @NSManaged public var letterId: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var isShared: Bool
    @NSManaged public var title: String?
    @NSManaged public var answer: NSSet?

}

// MARK: Generated accessors for answer
extension Letters {

    @objc(addAnswerObject:)
    @NSManaged public func addToAnswer(_ value: Answers)

    @objc(removeAnswerObject:)
    @NSManaged public func removeFromAnswer(_ value: Answers)

    @objc(addAnswer:)
    @NSManaged public func addToAnswer(_ values: NSSet)

    @objc(removeAnswer:)
    @NSManaged public func removeFromAnswer(_ values: NSSet)

}
