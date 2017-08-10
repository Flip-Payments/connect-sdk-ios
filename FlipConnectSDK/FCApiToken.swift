//
//  FCApiToken.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    static func requestAccessToken(authorizationCode code: String, redirectUri uri: String, clientSecret secret: String, clientID id: String, completion: @escaping (_ response: TokenResponse, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grant_type": "authorization_code",
            "authorization_code": "\(code)",
            "redirect_uri": "\(uri)",
            "client_secret": "\(secret)",
            "client_id": "\(id)"
        ]
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCApiUrls.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            let resp = TokenResponse(json: response)
            guard error == nil else {
                err = error
                completion(resp, err)
                return
            }
            
            if resp.success {
                UserDefaults.standard.accessToken = resp.accessToken
                UserDefaults.standard.userKey = resp.userKey
                UserDefaults.standard.refreshToken = resp.refreshToken
            }
            
            completion(resp, err)
        }
    }
    
    static func requestNewToken(refreshToken token: String, clientID id: String, clientSecret secret: String, redirectURI uri: String, completion: @escaping (_ response: TokenResponse, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grant_type": "refresh_token",
            "refresh_token": "\(token)",
            "client_id": "\(id)",
            "client_secret": "\(secret)",
            "redirect_uri": "\(uri)"
        ]
        
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCApiUrls.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            let resp = TokenResponse(json: response)
            guard error == nil else {
                err = error
                return
            }
            if resp.success {
                UserDefaults.standard.accessToken = resp.accessToken
                UserDefaults.standard.userKey = resp.userKey
                UserDefaults.standard.refreshToken = resp.refreshToken
            }
            completion(resp, err)
        }
    }
    
    static func requestVerifyToken(accessToken token: String, clientID id: String, clientSecret secret: String, completion: @escaping (_ response: TokenResponse, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grant_type": "verify_token",
            "access_token": "\(token)",
            "client_id": "\(id)",
            "client_secret": "\(secret)"
        ]
        
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCApiUrls.connectApiUrl)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            let resp = TokenResponse(json: response)
            guard error == nil else {
                err = error
                return
            }
            if resp.success {
                UserDefaults.standard.accessToken = resp.accessToken
                UserDefaults.standard.userKey = resp.userKey
            }
            completion(resp, err)
        }
    }
}
