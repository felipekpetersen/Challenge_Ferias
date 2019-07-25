//
//  Letter.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 18/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

//Zewu

import Foundation
import CoreData
import UIKit

class LetterSingleton{
    
    static let shared:LetterSingleton = LetterSingleton()
    
    var letterId: String?
    var title: String?
    var content: String?
//    var answers: [Answers]?
    var hasNotification: Bool?
    var isShared: Bool?
    var isFavorite: Bool?
    var createDate: String?
    var editDate: String?
    
    var context: NSManagedObjectContext?
    
    private init(){
        self.letterId = ""
        self.title = ""
        self.content = ""
        self.hasNotification = false
        self.isShared = false
        self.isFavorite = false
        self.createDate = ""
        self.editDate = ""
        
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func updateText(id: String, title: String?, content: String?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Letters")
        let predicate = NSPredicate(format: "letterId == '\(id)'")
        fetchRequest.predicate = predicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object[0] as! NSManagedObject
                objectUpdate.setValue(title, forKey: "title")
                objectUpdate.setValue(content, forKey: "content")
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print(error.code)
                }
                }
        } catch {
            print(error)
        }
    }
    
    func updateEditDate(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Letters")
        let predicate = NSPredicate(format: "letterId == '\(id)'")
        fetchRequest.predicate = predicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object[0] as! NSManagedObject
                objectUpdate.setValue(self.getDate(), forKey: "editDate")
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print(error.code)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func sendLetter(id: String, success: @escaping () -> ()) {
        var letter: NSManagedObject?
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Letters")
        let predicate = NSPredicate(format: "letterId == '\(id)'")
        fetchRequest.predicate = predicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                letter = object[0] as? NSManagedObject
            }
        } catch {
            print(error)
        }
        
        if let user = UserDefaults.standard.string(forKey: Constants.USER_UUID), let letterAux = letter, let letter = letterAux as? Letters {
            LetterRequest().sendLetter(userUuid: user, letter: letter) { (response, error) in
                if let _ = response {
                    success()
                    print("sent letter")
                } else {
                    print("error Letter")
                }
            }
        }
    }
    
    func updateShared(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Letters")
        let predicate = NSPredicate(format: "letterId == '\(id)'")
        fetchRequest.predicate = predicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object[0] as! NSManagedObject
                let isShared = objectUpdate.value(forKey: "isShared") as! Bool
                objectUpdate.setValue(!isShared, forKey: "isShared")
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print(error.code)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func updateFavorite(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Letters")
        let predicate = NSPredicate(format: "letterId == '\(id)'")
        fetchRequest.predicate = predicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object[0] as! NSManagedObject
                let isShared = objectUpdate.value(forKey: "isFavorite") as! Bool
                objectUpdate.setValue(!isShared, forKey: "isFavorite")
                do {
                    try managedContext.save()
                } catch let error as NSError {
                    print(error.code)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func deleteLetter(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Letters")
        let predicate = NSPredicate(format: "letterId == '\(id)'")
        fetchRequest.predicate = predicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                let objectUpdate = object[0] as! NSManagedObject
                context?.delete(objectUpdate)
            }
        } catch {
            print(error)
        }
    }
    
    func getDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    func create() -> Letters{
        guard let context = self.context else {return Letters()}
        
        let registry = NSEntityDescription.insertNewObject(forEntityName: "Letters", into: context) as! Letters
        registry.answer = []
        registry.letterId = UUID().uuidString
        registry.title = ""
        registry.content = ""
        registry.hasNotification = false
        registry.isShared = false
        registry.isFavorite = false
        registry.createDate = getDate()
        registry.editDate = ""
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return registry
    }
    
    func save(){
        guard let context = self.context else {return}
        
        let registry = NSEntityDescription.insertNewObject(forEntityName: "Letters", into: context) as! Letters
        registry.answer = []
        registry.letterId = self.letterId
        registry.title = self.title
        registry.content = self.content
        registry.hasNotification = self.hasNotification ?? false
        registry.isShared = self.isShared ?? false
        registry.isFavorite = self.isFavorite ?? false
        registry.createDate = self.createDate
        registry.editDate = self.editDate
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    func fetch() -> ([Letters]?, Error?){
        
        var fetchedLetters: [Letters]?
        var erro: Error?
        context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            fetchedLetters = try context!.fetch(Letters.fetchRequest())
        } catch {
            erro = error
            print(error.localizedDescription)
        }
        
        return (fetchedLetters, erro)
    }
    
}
