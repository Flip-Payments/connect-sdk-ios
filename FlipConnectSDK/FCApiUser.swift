//
//  FCApiUser.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 07/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func getUser(accessToken token: String, completion: @escaping (_ user: UserResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Accept-Language": "en-US",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        FCApi.request(toURL: URL(string: "\(FCConsts.connectUserManagementUrl)user/account")!, withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
            let user = UserResponse(json: response)
            guard error == nil else {
                err = error
                completion(user, err)
                return
            }
            
            completion(user, err)
        }
    }
    
    public static func getUser(publicToken token: String, accountKey key: String, completion: @escaping (_ user: UserResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Accept-Language": "en-US",
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        FCApi.request(toURL: URL(string: "\(FCConsts.connectPublicApiHostAddress)public/users/\(key)")!, withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
            let user = UserResponse(json: response)
            guard error == nil else {
                err = error
                completion(user, err)
                return
            }
            
            completion(user, err)
        }
    }
}
