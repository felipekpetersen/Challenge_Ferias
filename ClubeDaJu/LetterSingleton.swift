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
   
    func deleteLetter(id: String, success: @escaping () -> ()) {
        if let user = UserDefaults.standard.string(forKey: Constants.USER_UUID) {
            LetterRequest().deleteLetter(userUuid: user, letterId: id) { (response, error) in
                if let _ = response {
                    success()
                    print("delete letter")
                } else {
                    print("error delete Letter")
                }
            }
        }
    }
    
    func sendAnswer(userId: String, letterId: String, answer: AnswerCodable, success: @escaping () -> ()) {
        AnswerRequest().sendAnswer(userUuid: userId, letterId: letterId, answer: answer) { (response, error) in
            if let _ = response {
                success()
                print("answer Sent")
            } else {
                print("answer Error")
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
//                    self.sortLetters()
                } catch let error as NSError {
                    print(error.code)
                }
            }
        } catch {
            print(error)
        }
    }
    
    func sortLetters() {
        var fetchedLetters: [Letters]?
        var erro: Error?
        context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            fetchedLetters = try context!.fetch(Letters.fetchRequest())
            fetchedLetters?.sort{ $0.isFavorite && !$1.isFavorite }
        } catch {
            erro = error
            print(error.localizedDescription)
        }
    }
    
    func updateHasNotification(letter: Letters) {
        context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let object = letter as NSManagedObject
        object.setValue(true, forKey: "hasNotification")
        do {
            try context!.save()
        } catch let error as NSError {
            print(error.code)
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
                do {
                    try context?.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
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
    
    func fetchSorted() -> ([Letters]?, Error?){
        
        var fetchedLetters: [Letters]?
        var erro: Error?
        context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            fetchedLetters = try context!.fetch(Letters.fetchRequest())
            fetchedLetters?.sort{ $0.isFavorite && !$1.isFavorite }
        } catch {
            erro = error
            print(error.localizedDescription)
        }
        
        return (fetchedLetters, erro)
    }
    
    func setAllAnswersForRead(letter: Letters) {
        context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if let answers = letter.answer {
            for answer in answers {
                let object = answer as! NSManagedObject
                object.setValue(false, forKey: "isNewAnswer")
                do {
                    try context!.save()
                } catch let error as NSError {
                    print(error.code)
                }
            }
        }
        
        let object = letter as NSManagedObject
        object.setValue(false, forKey: "hasNotification")
        do {
            try context!.save()
        } catch let error as NSError {
            print(error.code)
        }
    }
    
//    func fetchAnswers() -> ([Answers]?, Error?){
//
//        var fetchedLetters: [Answers]?
//        var erro: Error?
//        context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        do {
//            fetchedLetters = try context!.fetch(Answers.fetchRequest())
//            if let fetchedLetters = fetchedLetters {
//                for letter in fetchedLetters {
//                    if letter.answerId == "123"{
//                        let object = letter as NSManagedObject
//                        object.setValue(false, forKey: "isNewAnswer")
//                        do {
//                            try context!.save()
//                        } catch let error as NSError {
//                            print(error.code)
//                        }
//                    }
//
//                }
//            }
//        } catch {
//            erro = error
//            print(error.localizedDescription)
//        }
//
//        return (fetchedLetters, erro)
//    }
    
    func saveAnswerFromRemoteDataSource(letter: Letters, answer: AnswerCodable) {
        guard let context = self.context else {return}
        
        let registry = NSEntityDescription.insertNewObject(forEntityName: "Answers", into: context) as! Answers
        registry.answerId = answer.answerId
        registry.content = answer.content
        registry.isNewAnswer = answer.isNewAnswer ?? true
        letter.addToAnswer(registry)
    }
    
    func saveLettersFromRemoteDataSource(letters: [LetterCodable]?) {
        if let letters = letters {
            var fetchedLetters: [Letters]?
            var erro: Error?
            context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            do {
                fetchedLetters = try context!.fetch(Letters.fetchRequest())
                
                /*procurar por cartas do banco e bater com as do CoreData
                 - Se tiver no banco e não no CoreData: A carta foi apagada do CoreData e deve ser removida do banco
                 -Se tiver no CoreData e não no banco e for compartilhada: deve tentar a request de enviar
                 */
                if let fetchedLetters = fetchedLetters {
                    for letter in letters {
                        let equalLetter = fetchedLetters.first(where: {$0.letterId == letter.letterId})
                        if equalLetter == nil {
                            if let letterId = letter.letterId {
                                self.deleteLetter(id: letterId)
                            }
                        }
                    }
                    for fetchedLetter in fetchedLetters {
                        if fetchedLetter.isShared {
                            let equalLetter = letters.first(where: {$0.letterId == fetchedLetter.letterId})
                            if equalLetter == nil {
                                if let letterId = fetchedLetter.letterId {
                                    self.sendLetter(id: letterId) {}
                                }
                            }
                        }
                    }
                }
                
                /* Salvar as respostas para a carta indicada */
                if let fetchedLetters = fetchedLetters {
                    for letter in letters {
                        for fetchedLetter in fetchedLetters {
                            if letter.letterId == fetchedLetter.letterId {
                                /*Salvar as respostas dentro de letter*/
                                if let fetchedAnswers = fetchedLetter.answer {
                                    if let fetchedAnswers = fetchedAnswers.allObjects as? [Answers] {
                                        for answer in letter.answers ?? [AnswerCodable]() {
                                            let equalAnswer = fetchedAnswers.first(where: {$0.answerId == answer.answerId})
//                                            let equalLetter = letter.first(where: {$0.letter.answer == fetchedAnswer.answerId})
                                            if equalAnswer == nil {
                                                    self.saveAnswerFromRemoteDataSource(letter: fetchedLetter, answer: answer)
                                                self.updateHasNotification(letter: fetchedLetter)
                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            } catch {
                erro = error
                print(error.localizedDescription)
            }
            
        }
    }
    
}
