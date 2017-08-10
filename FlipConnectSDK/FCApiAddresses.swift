//
//  FCApiAddresses.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func getAddresses(accessToken token: String, completion: @escaping (_ addresses: AddressesResponse, _ error: Error?) -> Void) {
        let headers: Headers = [
            "Authorization": "bearer \(token)"
        ]
        
        var err: Error? = nil
        FCApi.request(toURL: URL(string: "\(FCApiUrls.connectUserManagementUrl)user/account/addresses")!, withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
            let addresses = AddressesResponse(json: response)
            guard error == nil else {
                err = error
                completion(addresses, err)
                return
            }
            
            completion(addresses, err)
        }
    }
    
//    public static func getAddresses(publicToken token: String, accountKey key: String, completion: @escaping (_ user: AddressesResponse, _ error: Error?) -> Void) {
//        let headers: Headers = [
//            "Authorization": "bearer \(token)"
//        ]
//        
//        var err: Error? = nil
//        FCApi.request(toURL: URL(string: "\(FCConsts.connectPublicApiHostAddress)public/users/\(key)/addresses")!, withVerb: .get, withParameters: nil, withHeaders: headers) { response, error in
//            let addresses = AddressesResponse(json: response)
//            guard error == nil else {
//                err = error
//                completion(addresses, err)
//                return
//            }
//            
//            completion(addresses, err)
//        }
//    }
}
