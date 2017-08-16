//
//  FCApiToken.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 27/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension FCApi {
    
    /**
     Access Token is rescued after successful login redirection
     - Parameters:
        - completion: Callback
        - response: `TokenResponse` type that should come with success `true` if the request is successful
        - error: Should be `nil` on a successful request
     */
    static func requestAccessToken(completion: @escaping (_ response: TokenResponse, _ error: Error?) -> Void) {
        let parameters: Parameters = [
            "grant_type": "authorization_code",
            "authorization_code": "\(FCConfiguration.authorizationCode)",
            "redirect_uri": "\(FCConfiguration.redirectURI)",
            "client_secret": "\(FCConfiguration.clientSecret)",
            "client_id": "\(FCConfiguration.clientID)"
        ]
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConfiguration.environment.apiURL)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
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
    
    /**
     Refresh Token to update your Access Token
     - Parameters:
        - completion: Callback
        - response: `TokenResponse` type that should come with success `true` if the request is successful
        - error: Should be `nil` on a successful request
     */
    public static func requestTokenRefresh(completion: @escaping (_ response: TokenResponse, _ error: Error?) -> Void) {
        var resp = TokenResponse(json: [:])
        guard let token = UserDefaults.standard.refreshToken else {
            completion(resp, FCErrors.refreshTokenNotFound)
            return
        }
        
        let parameters: Parameters = [
            "grant_type": "refresh_token",
            "refresh_token": "\(token)",
            "client_id": "\(FCConfiguration.clientID)",
            "client_secret": "\(FCConfiguration.clientSecret)",
            "redirect_uri": "\(FCConfiguration.redirectURI)"
        ]
        
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConfiguration.environment.apiURL)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            resp = TokenResponse(json: response)
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
    
    /**
     Verify Token to guarantee you can get data from the User
     - Parameters:
        - completion: Callback
        - response: `TokenResponse` type that should come with success `true` if the request is successful
        - error: Should be `nil` on a successful request
     */
    public static func requestTokenVerification(completion: @escaping (_ response: TokenResponse, _ error: Error?) -> Void) {
        var resp = TokenResponse(json: [:])
        guard let token = UserDefaults.standard.accessToken else {
            completion(resp, FCErrors.accessTokenNotFound)
            return
        }
        
        let parameters: Parameters = [
            "grant_type": "verify_token",
            "access_token": "\(token)",
            "client_id": "\(FCConfiguration.clientID)",
            "client_secret": "\(FCConfiguration.clientSecret)"
        ]
        
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConfiguration.environment.apiURL)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            resp = TokenResponse(json: response)
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
    
    /**
     Revoke Token so the user will not be "logged" anymore
     - Parameters:
        - completion: Callback
        - response: `TokenResponse` type that should come with success `true` if the request is successful
        - error: Should be `nil` on a successful request
    */
    public static func requestTokenRevocation(completion: @escaping(_ response: TokenResponse, _ error: Error?) -> Void) {
        var resp = TokenResponse(json: [:])
        guard let token = UserDefaults.standard.accessToken else {
            completion(resp, FCErrors.accessTokenNotFound)
            return
        }
        
        let parameters: Parameters = [
            "grant_type": "revoke_token",
            "access_token": "\(token)",
            "client_id": "\(FCConfiguration.clientID)",
            "client_secret": "\(FCConfiguration.clientSecret)"
        ]
        
        var err: Error? = nil
        
        FCApi.request(toURL: URL(string: "\(FCConfiguration.environment.apiURL)oauth/token")!, withVerb: .post, withParameters: parameters) { response, error in
            resp = TokenResponse(json: response)
            guard error == nil else {
                err = error
                return
            }
            if resp.success {
                UserDefaults.standard.accessToken = nil
                UserDefaults.standard.userKey = nil
                UserDefaults.standard.refreshToken = nil
            }
            completion(resp, err)
        }
    }
}
