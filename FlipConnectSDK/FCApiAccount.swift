//
//  FCApiAccount.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 24/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func updateAccount(accessToken token: String, _ patches: Patches, completion: @escaping (_ response: GenericResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        
        let json = patches.createDictionary()
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectUserManagementUrl)user/account")!, withVerb: .patch, withHeaders: headers, withBody: json) { res, error in
            let genericResponse = GenericResponse(json: res)
            guard error == nil else {
                err = error
                completion(genericResponse, err)
                return
            }
            completion(genericResponse, err)
        }
    }
    
    static func createTemporaryProfile(_ temporaryProfile: TemporaryProfileRequest, clientID: String, completion: @escaping (_ response: TemporaryProfileResponse, _ error: Error?) -> Void) {
        var err: Error? = nil
        
        let json = temporaryProfile.toDictionary()
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectUserManagementUrl)user/account/savePendingProfile/\(clientID)")!, withVerb: .post, withBody: json) { res, error in
            let temporaryProfileResponse = TemporaryProfileResponse(json: res)
            guard error == nil else {
                err = error
                completion(temporaryProfileResponse, err)
                return
            }
            completion(temporaryProfileResponse, err)
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
