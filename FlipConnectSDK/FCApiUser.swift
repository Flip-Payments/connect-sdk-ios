//
//  FCApiUser.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 07/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func createTemporaryProfile(_ temporaryProfile: TemporaryProfile, clientID: String, completion: @escaping (_ response: TemporaryProfileResponse, _ error: Error?) -> Void) {
        var err: Error? = nil
        
        var request = TemporaryProfileRequest()
        request.clientID = clientID
        request.data = temporaryProfile
        
        let json = request.toDictionary()
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectUserManagementUrl)user/temporaryProfile")!, withVerb: .post, withBody: json) { res, error in
            let temporaryProfileResponse = TemporaryProfileResponse(json: res)
            guard error == nil else {
                err = error
                completion(temporaryProfileResponse, err)
                return
            }
            completion(temporaryProfileResponse, err)
        }
    }
    
    public static func getUser(publicToken token: String, accountKey key: String, categories: [FCEditCategoriesEnum]? = nil, completion: @escaping (_ user: UserResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        FCApi.request(toURL: toURL(key, categories), withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
            let user = UserResponse(json: response)
            guard error == nil else {
                err = error
                completion(user, err)
                return
            }
            
            completion(user, err)
        }
    }
    
    private static func toURL(_ key: String, _ categories: [FCEditCategoriesEnum]? = nil) -> URL {
        var urlString = "\(FCConsts.connectPublicApiHostAddress)public/users/\(key)"
        
        if let categories = categories, categories.count > 0 {
            urlString.append("?")
            for category in categories {
                switch category {
                case .Addresses:
                    urlString.append("include=addresses&")
                case .Documents:
                    urlString.append("include=documents&")
                case .Emails:
                    urlString.append("include=emails&")
                case .PersonalData:
                    urlString.append("include=personaldata&")
                case .Phones:
                    urlString.append("include=phones&")
                default: break
                }
            }
            urlString.remove(at: urlString.index(before: urlString.endIndex))
        }
        
        return URL(string: urlString)!
    }
}
