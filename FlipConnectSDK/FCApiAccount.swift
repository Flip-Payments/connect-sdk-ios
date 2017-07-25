//
//  FCApiAccount.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 24/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func getAccount(accessToken token: String, completion: @escaping (_ user: AccountResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        FCApi.request(toURL: URL(string: "\(FCConsts.connectUserManagementUrl)user/account")!, withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
            let account = AccountResponse(json: response)
            guard error == nil else {
                err = error
                completion(account, err)
                return
            }
            
            completion(account, err)
        }
    }
}
