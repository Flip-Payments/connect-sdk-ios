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
     Create `FCEnvironmentEnum` by passing a `String`.
     Default value is `.sandbox`.
     
     - parameters:
        - rawValue: String that contains corresponding value to the enumerator
    */
    public init(rawValue: String) {
        ApiUrls.isStaging = false
        switch rawValue.lowercased() {
        case "production":
            self = .production
        case "sandbox":
            self = .sandbox
        case "staging":
            ApiUrls.isStaging = true
            self = .sandbox
        default:
            self = .sandbox
        }
    }
    
    /**
     Return Web URL to open login page
    */
    internal var webURL: String {
        get {
            if ApiUrls.isStaging { return ApiUrls.connectStagingWebUrl }
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
            if ApiUrls.isStaging { return ApiUrls.connectStagingApiUrl }
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
            if ApiUrls.isStaging { return ApiUrls.connectStagingUserManagementUrl }
            switch self {
            case .production:
                return ApiUrls.connectProductionUserManagementUrl
            case .sandbox:
                return ApiUrls.connectSandboxUserManagementUrl
            }
        }
    }
    
    private struct ApiUrls {
        static var isStaging: Bool = false
        
        static let connectStagingWebUrl = "http://flipconnect-signin-develop.herokuapp.com/"
        static let connectStagingApiUrl = "http://dlp-qrservices.cloudapp.net:20112/api/"
        static let connectStagingUserManagementUrl = "http://dlp-qrservices.cloudapp.net:20115/"
        
        static let connectSandboxWebUrl = "https://signin-sandbox.flipconnect.io/"
        static let connectSandboxApiUrl = "https://auth-sandbox.flipconnect.io/api/"
        static let connectSandboxUserManagementUrl = "https://api-sandbox.flipconnect.io/"
        
        static let connectProductionWebUrl = "https://signin.flipconnect.io/"
        static let connectProductionApiUrl = "https://auth.flipconnect.io/api/"
        static let connectProductionUserManagementUrl = "https://api.flipconnect.io/"
    }
}
