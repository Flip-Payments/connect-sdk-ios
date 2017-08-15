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
        static let connectSandboxWebUrl = "http://flipconnect-signin-develop.herokuapp.com/"
        static let connectSandboxApiUrl = "http://dlp-qrservices.cloudapp.net:20112/api/"
        static let connectSandboxUserManagementUrl = "http://dlp-qrservices.cloudapp.net:20115/"
        
        static let connectProductionWebUrl = "http://flipconnect-signin-develop.herokuapp.com/"
        static let connectProductionApiUrl = "http://dlp-qrservices.cloudapp.net:20112/api/"
        static let connectProductionUserManagementUrl = "http://dlp-qrservices.cloudapp.net:20115/"
    }
}
