//
//  FCEnvironmentEnum.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 10/08/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

/// Environment to use API
public enum FCEnvironmentEnum: String {
    /// Sandbox Environment
    case sandbox
    
    /// Production Environment
    case production
    
    /**
     Return Web URL to open login page
    */
    internal var webURL: String {
        get {
            switch self {
            case .production:
                return ApiUrls.connectProductionWebUrl
            case .sandbox:
                return ApiUrls.connectSandboxWebUrl
            }
        }
    }
    
    /**
     Return API URL to communicate with the Authentication API
    */
    internal var apiURL: String {
        get {
            switch self {
            case .production:
                return ApiUrls.connectProductionApiUrl
            case .sandbox:
                return ApiUrls.connectSandboxApiUrl
            }
        }
    }
    
    /**
     Return API URL to communicate with the Management API
     */
    internal var userManagementURL: String {
        get {
            switch self {
            case .production:
                return ApiUrls.connectProductionUserManagementUrl
            case .sandbox:
                return ApiUrls.connectSandboxUserManagementUrl
            }
        }
    }
    
    private struct ApiUrls {
        static let connectSandboxWebUrl = "https://signin-sandbox.flipconnect.io/"
        static let connectSandboxApiUrl = "https://auth-sandbox.flipconnect.io/api/"
        static let connectSandboxUserManagementUrl = "https://api-sandbox.flipconnect.io/"
        
        static let connectProductionWebUrl = "https://signin.flipconnect.io/"
        static let connectProductionApiUrl = "https://auth.flipconnect.io/api/"
        static let connectProductionUserManagementUrl = "https://api.flipconnect.io/"
    }
}
