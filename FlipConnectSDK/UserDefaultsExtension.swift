//
//  UserDefaultsExtension.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 06/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

extension UserDefaults {
    private struct Keys {
        static let AuthorizationCode = "FCAuthorizationCode"
        static let State = "FCState"
        static let ClientID = "FCClientID"
        static let AccessToken = "FCAccessToken"
        static let RefreshToken = "FCRefreshToken"
    }
    
    public internal(set) var authorizationCode: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AuthorizationCode)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AuthorizationCode)
        }
    }
    
    public internal(set) var state: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.State)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.State)
        }
    }
    
    public internal(set) var clientID: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.ClientID)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.ClientID)
        }
    }
    
    public internal(set) var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AccessToken)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AccessToken)
        }
    }
    
    public internal(set) var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.RefreshToken)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.RefreshToken)
        }
    }
}
