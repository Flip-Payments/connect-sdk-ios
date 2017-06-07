//
//  Utils.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 06/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

struct Utils {
    
    private let identifier = "FlipConnectSDK"
    private let urlNameKey = "CFBundleURLName"
    private let urlTypeKey = "CFBundleURLTypes"
    private let urlSchemeKey = "CFBundleURLSchemes"
    private let urlQueryStateKey = "state"
    private let urlQueryAuthCodeKey = "authcode"
    
    private var plist: JSON = [:]
    private var config: [JSON] = [[:]]
    
    /// Scheme used for DeepLinking
    let urlScheme: String
    
    init(jsonArray: JSON?) throws {
        
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
                throw FCErrors.incorrectIdentifier
            }
            
            urlScheme = schemeUrl
        }
        
        self.plist = plist
        self.config = config
        self.urlScheme = urlScheme.lowercased()
    }
    
    func mountWebURL(withRedirectUri uri: URL, andID clientID: String) -> URL {
        UserDefaults.standard.state = UUID().uuidString
        return URL(string: "\(FCConsts.connectWebUrl)?clientId=\(clientID)&redirectUri=\(uri.absoluteString)&state=\(UserDefaults.standard.state!)&responseType=code")!
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
        
        //TODO: Verificar State
        let stateValue = items.filter{ $0.name.lowercased() == urlQueryStateKey }.first?.value
        
        guard stateValue! == UserDefaults.standard.state! else {
            throw FCErrors.stateIsInvalid
        }
        
        guard items.first?.name.lowercased() == urlQueryAuthCodeKey, let propertyValue = items.first?.value else {
            throw FCErrors.wrongParameters(message: "Parameters from URI are not correct")
        }
        
        UserDefaults.standard.authorizationCode = propertyValue
    }
}
