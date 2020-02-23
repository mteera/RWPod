//
//  Service.swift
//  GedditChallenge
//
//  Created by Chace Teera on 17/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import Foundation
import Alamofire

class Service {

    
    static let shared = Service()
    
    var products = [Product]()
    
    
    // declare my generic json function here
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data!)
                // success
                completion(objects, nil)
            } catch {
                completion(nil, error)
            }
            }.resume()
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?)-> Void) {

        let parameters: [String: Any] = [
            "email": email,
            "password": password

        ]

        AF.request("https://api.live.dev.gedditlive.com/v1/test/login", method: .post, parameters: parameters).response { (response) in

            switch response.result {
            case .success(let data):

                do {
                    
                    
                    guard let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] else { return }


                    guard let data = json["data"] as? [String: Any]  else {
                        
                        if let errorObj = json["error"] as? [String: Any] {
                            
                            let error = NSError(domain:"", code: errorObj["code"] as! Int, userInfo:[ NSLocalizedDescriptionKey: errorObj["message"] as! String])
                            completion(error)
                        }

                        return
                        
                    }

                    
                    let encoder = JSONEncoder()
                    let user = User(name: data["name"] as! String, accessToken: data["access_token"] as! String, consecutiveRoundCount: data["consecutive_round_count"] as! Int, email: data["email"] as! String)
                    if let encoded = try? encoder.encode(user) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "SavedUser")
                        completion(nil)

                    }
                    
                    

                } catch {
                    completion(error)

                }
                // Do your code here...

            case .failure(let error):
                
                completion(error)

                // Do your code here...

            }
        }
    }

}
