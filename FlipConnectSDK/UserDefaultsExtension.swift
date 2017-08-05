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
        static let ClientSecret = "FCClientSecret"
        static let AccessToken = "FCAccessToken"
        static let RefreshToken = "FCRefreshToken"
        static let PublicToken = "FCPublicToken"
        static let UserKey = "FCUserKey"
        static let RedirectURI = "FCRedirectURI"
        static let FingerPrintID = "FCFingerPrintID"
    }
    
    internal var authorizationCode: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.AuthorizationCode)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.AuthorizationCode)
        }
    }
    
    internal var fingerPrintID: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.FingerPrintID)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.FingerPrintID)
        }
    }
    
    internal var state: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.State)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.State)
        }
    }
    
    internal var clientID: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.ClientID)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.ClientID)
        }
    }
    
    internal var clientSecret: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.ClientSecret)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.ClientSecret)
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
    
    /// Token used to make requests to FlipConnect public API
    public internal(set) var publicToken: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.PublicToken)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.PublicToken)
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
    public internal(set) var accountKey: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.UserKey)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.UserKey)
        }
    }
    
    internal var redirectURI: String? {
        get {
            return UserDefaults.standard.string(forKey: Keys.RedirectURI)
        } set {
            UserDefaults.standard.set(newValue, forKey: Keys.RedirectURI)
        }
    }
}
