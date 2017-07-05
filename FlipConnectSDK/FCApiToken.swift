//
//  FCApiToken.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func requestAccessToken(authorizationCode code: String, redirectUri uri: String, clientSecret secret: String, clientID id: String, completion: @escaping (_ response: JSON, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grantType": "authorization_code",
            "authorizationCode": "\(code)",
            "redirectUri": "\(uri)",
            "clientSecret": "\(secret)",
            "clientId": "\(id)"
        ]
        
        var resp = JSON()
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            guard error == nil else {
                err = error
                completion(resp, err)
                return
            }
            resp = response
            
            completion(resp, err)
        }
    }
    
    static func requestNewToken(refreshToken token: String, clientID id: String, clientSecret secret: String, redirectURI uri: String, completion: @escaping (_ response: JSON, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grantType": "refresh_token",
            "refreshToken": "\(token)",
            "clientId": "\(id)",
            "clientSecret": "\(secret)",
            "redirectUri": "\(uri)"
        ]
        
        var resp = JSON()
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            guard error == nil else {
                err = error
                return
            }
            resp = response
            completion(resp, err)
        }
    }
    
    static func requestVerifyToken(accessToken token: String, clientID id: String, clientSecret secret: String, completion: @escaping (_ response: JSON, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grantType": "verify_token",
            "accessToken": "\(token)",
            "clientId": "\(id)",
            "clientSecret": "\(secret)"
        ]
        
        var resp = JSON()
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            guard error == nil else {
                err = error
                return
            }
            resp = response
            completion(resp, err)
        }
    }
    
    static func requestPublicToken(clientID id: String, clientSecret secret: String, completion: @escaping (_ response: JSON, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grantType": "client_credentials",
            "clientId": "\(id)",
            "clientSecret": "\(secret)"
        ]
        
        var resp = JSON()
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConsts.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            guard error == nil else {
                err = error
                return
            }
            resp = response
            completion(resp, err)
        }
    }
}
