//
//  FCEditUser.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 28/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

public class FCEditUser {
    public init() {}
    
    public func loadView(completion: @escaping (_ viewController: UIViewController) -> Void) {
        var viewController: UIViewController = UIViewController()
        DispatchQueue.main.async {
            let s = UIStoryboard (
                name: "RegistrationEditionStoryboard", bundle: Bundle(for: RegistrationEditionViewController.self)
            )
            viewController = s.instantiateViewController(withIdentifier: "RegistrationEditionViewController")
            
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: RegistrationEditionViewController.self, action: Selector(("dismiss")))
            
//            vc = UINavigationController(rootViewController: v)
            completion(viewController)
        }
    }
}
