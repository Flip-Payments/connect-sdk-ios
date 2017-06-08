//
//  FCLogin.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 08/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation
import UIKit

public final class FCLogin {
    private init() {}
    
    static let shared = FCLogin()
    
    func loginWithButton() {
        
    }
    
    @objc public func loginButtonClicked() {
        openLoginURL()
    }
    
    public func openLoginURL() {
        let url = FCConsts.mountWebURL(withRedirectUri: URL(string: FCConsts.connectWebUrl)!, andID: "")
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
