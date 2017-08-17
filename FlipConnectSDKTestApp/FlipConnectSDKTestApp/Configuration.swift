//
//  Configuration.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 16/08/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation
import FlipConnectSDK

public class Configuration {
    static var fcLogin: FCLogin? = nil
    
    private static var _env = FCEnvironmentEnum.sandbox
    static var environment: FCEnvironmentEnum {
        get {
            return Configuration._env
        } set {
            Configuration._env = newValue
            Configuration.setEnvironment(newValue)
        }
    }
    
    static let clientID = "5149B5B2-0463-4752-A8A0-C37D639A1FE4"
    static let clientSecret = "FC3E9D34-978B-483B-9CC0-462DFB82A75B"
    static let redirectURI = "ipirangaConnect://ipiranga"
    static let fingerPrintID = "c470458e-7845-4380-a5db-e7e28548c243"
    
    private static func setEnvironment(_ env: FCEnvironmentEnum) {
        _ = FCConfiguration(environment: Configuration.environment,
                            clientID: Configuration.clientID,
                            clientSecret: Configuration.clientSecret,
                            redirectURI: Configuration.redirectURI,
                            fingerPrintID: Configuration.fingerPrintID)
    }
    
    public static func showErrorDialog(_ error: String, on viewController: UIViewController) {
        let alertController = UIAlertController(title: "Erro", message: "\(error)", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            (result : UIAlertAction) -> Void in
        }
        
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
