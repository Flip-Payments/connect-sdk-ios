//
//  FCApiUser.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 07/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func createTemporaryProfile(_ temporaryProfile: TemporaryProfile, completion: @escaping (_ response: TemporaryProfileResponse, _ error: Error?) -> Void) {
        var err: Error? = nil
        
        var request = TemporaryProfileRequest()
        request.clientID = FCConfiguration.clientID
        request.data = temporaryProfile
        
        let json = request.toDictionary()
        
        FCApi.request(toURL: URL(string: "\(FCConfiguration.environment.userManagementURL)user/temporaryProfile")!, withVerb: .post, withBody: json) { res, error in
            let temporaryProfileResponse = TemporaryProfileResponse(json: res)
            guard error == nil else {
                err = error
                completion(temporaryProfileResponse, err)
                return
            }
            completion(temporaryProfileResponse, err)
        }
    }
    
//    public static func getAccount(publicToken token: String, accountKey key: String, categories: [FCCategoriesEnum]? = nil, completion: @escaping (_ user: AccountResponse, _ error: Error?) -> Void) {
//        let headers: Headers = [
//            "Authorization": "bearer \(token)"
//        ]
//        
//        var err: Error? = nil
//        FCApi.request(toURL: toURL(key, categories), withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
//            let user = UserResponse(json: response)
//            guard error == nil else {
//                err = error
//                completion(user, err)
//                return
//            }
//            
//            completion(user, err)
//        }
//    }
    
    // TODO: return Parameters instead of URL, this for is useless
    private static func toURL(_ key: String, _ categories: [FCCategoriesEnum]? = nil) -> URL {
        var urlString = "\(FCConfiguration.environment.userManagementURL)user/account?\(key)"
        
        if let categories = categories, categories.count > 0 {
            urlString.append("?")
            for category in categories {
                switch category {
                case .addresses:
                    urlString.append("include=addresses&")
                case .documents:
                    urlString.append("include=documents&")
                case .emails:
                    urlString.append("include=emails&")
                case .personalData:
                    urlString.append("include=personaldata&")
                case .phones:
                    urlString.append("include=phones&")
                default: break
                }
            }
            urlString.remove(at: urlString.index(before: urlString.endIndex))
        }
        
        return URL(string: urlString)!
    }
}
