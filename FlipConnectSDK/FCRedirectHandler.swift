//
//  Utils.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 06/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

struct FCRedirectHandler {
    
    private let identifier = "FlipConnectSDK"
    private let urlNameKey = "CFBundleURLName"
    private let urlTypeKey = "CFBundleURLTypes"
    private let urlSchemeKey = "CFBundleURLSchemes"
    private let urlQueryStateKey = "state"
    private let urlQueryAuthCodeKey = "code"
    private let authorizeOperation = "authorize"
    
    private var plist: JSON = [:]
    private var config: [JSON] = [[:]]
    
    /// Scheme used for DeepLinking
    let urlScheme: String
    
    init(bundle jsonArray: JSON?) throws {
        
        guard let plist = jsonArray else {
            throw FCErrors.plistNotFound
        }
        
        guard let config = plist[urlTypeKey] as? [JSON], !config.isEmpty else {
            throw FCErrors.configNotFound
        }
        
        var urlScheme = ""
        for item in config {
            guard let urlID = item[urlNameKey] as? String else {
                throw FCErrors.urlNameDifferentFromIdentifier
            }
            guard let scheme = item[urlSchemeKey] as? [String],
                let schemeUrl = scheme.first else {
                    throw FCErrors.urlSchemeDoesNotExist
            }
            
            guard urlID == identifier else {
                continue
            }
            
            urlScheme = schemeUrl
        }
        if urlScheme.isEmpty {
            throw FCErrors.incorrectIdentifier
        }
        
        self.plist = plist
        self.config = config
        self.urlScheme = urlScheme.lowercased()
    }
    
    func mountWebURL(url: URL, withRedirectUri uri: String, andID clientID: String, dataKey: String? = nil) -> URL {
        UserDefaults.standard.state = UUID().uuidString
        var dataKeyURL: String = ""
        if let dataKey = dataKey {
            dataKeyURL = "&data_key=\(dataKey)"
        }
        return URL(string: "\(url.absoluteString)?client_id=\(clientID)&redirect_uri=\(uri)&state=\(UserDefaults.standard.state!)&response_type=code\(dataKeyURL)")!
    }
    
    func handleURI(open url: URL) throws {
        guard url.scheme?.lowercased() == self.urlScheme else {
            // it don't throws because it can be any URL
            return
        }
        
        let urlComponents = URLComponents(string: url.absoluteString)
        
        guard let items = urlComponents!.queryItems else {
            throw FCErrors.malformedURI
        }
        
        // Verify if the state is valid
        let stateValue = items.filter{ $0.name.lowercased() == urlQueryStateKey }.first?.value
        guard stateValue! == UserDefaults.standard.state! else {
            throw FCErrors.stateIsInvalid
        }
        
        //deeplink://something?operation=authorize&code=f117d5fe-a5ef-40bd-b171-55c8210c1cbd&state=undefined
        guard let operation = items.first?.value! else {
            throw FCErrors.invalidOperation
        }
        
        switch operation {
        case authorizeOperation:
            try handleAuthorizeRedirect(queryItems: items)
        default:
            throw FCErrors.invalidOperation
        }
    }
    
    func handleAuthorizeRedirect(queryItems items: [URLQueryItem]) throws {
        let authorizationCode = items.filter{ $0.name == urlQueryAuthCodeKey }.first
        
        guard let propertyValue = authorizationCode?.value else {
            throw FCErrors.wrongParameters(message: "\(urlQueryAuthCodeKey) was not found as a parameter")
        }
        
        UserDefaults.standard.authorizationCode = propertyValue
    }
}
