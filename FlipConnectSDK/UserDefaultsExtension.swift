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
        static let AccessToken = "FCAccessToken"
        static let RefreshToken = "FCRefreshToken"
        static let UserKey = "FCUserKey"
        static let FingerPrintSessionID = "FCRLFingerPrintSessionID"
    }
    
    internal var authorizationCode: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AuthorizationCode)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AuthorizationCode)
        }
    }
    
    internal var state: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.State)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.State)
        }
    }
    
    /// Token used to make requests to FlipConnect
    public internal(set) var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AccessToken)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AccessToken)
        }
    }
    
    internal var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.RefreshToken)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.RefreshToken)
        }
    }
    
    /// UserKey is the key of the User
    public internal(set) var userKey: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.UserKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.UserKey)
        }
    }
    
    /// fingerPrintSessionID is the ID generated for the session of the user
    public internal(set) var fingerPrintSessionID: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.FingerPrintSessionID)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.FingerPrintSessionID)
        }
    }
}
