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
}
