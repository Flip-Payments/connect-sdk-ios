//
//  FCApiAccount.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 24/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func updateAccount(accessToken token: String, body json: JSON, completion: @escaping (_ error: Error?) -> Void) {
        let headers: Headers = [
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectUserManagementUrl)user/account")!, withVerb: .patch, withHeaders: headers, withBody: json) { response, error in
            guard error == nil else {
                err = error
                completion(err)
                return
            }
        }
    }
    
    static func getAccount(accessToken token: String, categories: [FCEditCategoriesEnum]? = nil, completion: @escaping (_ user: AccountResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        FCApi.request(toURL: toURL(categories), withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
            let account = AccountResponse(json: response)
            guard error == nil else {
                err = error
                completion(account, err)
                return
            }
            
            completion(account, err)
        }
    }
    
    private static func toURL(_ categories: [FCEditCategoriesEnum]? = nil) -> URL {
        var urlString = "\(FCConsts.connectUserManagementUrl)user/account"

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
