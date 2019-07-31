//
//  UserRequest.swift
//  ClubeDaJu
//
//  Created by Felipe Petersen on 25/07/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation

class UserRequest {
    
    //SignUp Request
    func signUp(uuid: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup() // initialize the async
        group.enter()
        let parameters = ["uuid": uuid]
        //create the url with NSURL
        let url = URL(string: RequestConstants.POST_SIGNUP)!
        
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
                                group.leave()
                            } else {
                                completion(json, nil)
                                group.leave()
                            }
                        } else {
                            completion(nil, nil)
                            group.leave()
                        }
                    }
                    
                } else {
                    group.leave()
                    print("no file")
                    
                }
                
            } catch {
                group.leave()
                print(error.localizedDescription)
                
            }
        })
        
        task.resume()
        
    }
    
    //SignUp Request
    func registerToken(uuid: String, token: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let group = DispatchGroup() // initialize the async
        group.enter()
        let parameters = ["uuid": uuid, "token": token]
        //create the url with NSURL
        let url = URL(string: RequestConstants.POST_TOKEN)!
        
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
                                group.leave()
                            } else {
                                completion(json, nil)
                                group.leave()
                            }
                        } else {
                            completion(nil, nil)
                            group.leave()
                        }
                    }
                    
                } else {
                    group.leave()
                    print("no file")
                    
                }
                
            } catch {
                group.leave()
                print(error.localizedDescription)
                
            }
        })
        
        task.resume()
        
    }
}
