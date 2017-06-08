//
//  FCConsts.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 07/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

struct FCConsts {
    static let connectWebUrl = "http://flipconnect-signin-staging.herokuapp.com/"
    static let connectApiUrl = "http://dlp-qrservices.cloudapp.net:20112/api/"
    
    static func mountWebURL(withRedirectUri uri: URL, andID clientID: String) -> URL {
        UserDefaults.standard.state = UUID().uuidString
        return URL(string: "\(FCConsts.connectWebUrl)?clientId=\(clientID)&redirectUri=\(uri.absoluteString)&state=\(UserDefaults.standard.state!)&responseType=code")!
    }
}
