//
//  LetterRequest.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 25/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation

class LetterRequest {
    
    //SendLetter
    func sendLetter(userUuid: String, letter: Letters, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup() // initialize the async
        group.enter()
        let letterParams = ["letterId": letter.letterId, "title": letter.title, "content": letter.content, "hasNotification": false, "isShared": true, "createDate": letter.createDate, "editDate": letter.editDate, "ownerUuid": UserDefaults.standard.string(forKey: Constants.USER_UUID) ?? ""] as [String : Any]
        let parameters = ["userUuid": userUuid, "Letter": letterParams] as [String : Any]
        //create the url with NSURL
        let url = URL(string: RequestConstants.POST_ADDLETTER)!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" //set http method as POST
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            group.leave()
            
            
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                
                do {
                    
                    print(data)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: []) as! [String:Any]
                        print(json)
                        for (key, value) in json {
                            if (key == "result"){
                                if(value as? Int == 0){
                                    completion(nil, nil)
                                } else {
                                    completion(json, nil)
                                }
                            } else {
                                completion(nil, nil)
                            }
                        }
                        
                    } else {
                        print("no file")
                        
                    }
                    
                } catch {
                    print(error.localizedDescription)
                    
                }
            })
            
        })
        task.resume()
    }
    
    //DeleterLetter
    func deleteLetter(userUuid: String, letterId: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup() // initialize the async
        group.enter()
        let parameters = ["userUuid": userUuid, "letterId": letterId] as [String : Any]
        //create the url with NSURL
        let url = URL(string: RequestConstants.POST_DELETELETTER)!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" //set http method as POST
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            group.leave()
            
            
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                
                do {
                    
                    print(data)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: []) as! [String:Any]
                        print(json)
                        for (key, value) in json {
                            if (key == "result"){
                                if(value as? Int == 0){
                                    completion(nil, nil)
                                } else {
                                    completion(json, nil)
                                }
                            } else {
                                completion(nil, nil)
                            }
                        }
                        
                    } else {
                        print("no file")
                        
                    }
                    
                } catch {
                    print(error.localizedDescription)
                    
                }
            })
            
        })
        
        task.resume()
        
    }
    
    func updateLetter(userUuid: String, letter: Letters, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup() // initialize the async
        group.enter()
        let letterParams = ["letterId": letter.letterId, "title": letter.title, "content": letter.content, "hasNotification": false, "isShared": true, "createDate": letter.createDate, "editDate": letter.editDate, "ownerUuid": UserDefaults.standard.string(forKey: Constants.USER_UUID) ?? ""] as [String : Any]
        let parameters = ["userUuid": userUuid, "Letter": letterParams] as [String : Any]
        //create the url with NSURL
        let url = URL(string: RequestConstants.POST_UPDATELETTER)!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST" //set http method as POST
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Acadresst")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            group.leave()
            
            
            group.notify(queue: .main, execute: {
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard data != nil else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                
                do {
                    
                    print(data)
                    if let file = data {
                        let json = try JSONSerialization.jsonObject(with: file, options: []) as! [String:Any]
                        print(json)
                        for (key, value) in json {
                            if (key == "result"){
                                if(value as? Int == 0){
                                    completion(nil, nil)
                                } else {
                                    completion(json, nil)
                                }
                            } else {
                                completion(nil, nil)
                            }
                        }
                        
                    } else {
                        print("no file")
                        
                    }
                    
                } catch {
                    print(error.localizedDescription)
                    
                }
            })
            
        })
        task.resume()
    }

}
