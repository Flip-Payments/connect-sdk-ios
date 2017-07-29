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
    
    public static func loadView(categories: [FCEditCategoriesEnum], completion: @escaping (_ viewController: UIViewController) -> Void) {
//        var viewController: UIViewController = UIViewController()
        
        let uniqueCategories = Array(Set(categories))
        
        let sortedCategories = uniqueCategories.sorted { $0 < $1 }
        
        DispatchQueue.main.async {
            let s = UIStoryboard (
                name: "RegistrationEditionStoryboard", bundle: Bundle(for: RegistrationEditionViewController.self)
            )
            let viewController = s.instantiateViewController(withIdentifier: "RegistrationEditionViewController") as! RegistrationEditionViewController
            
            viewController.sections = sortedCategories
            
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: RegistrationEditionViewController.self, action: Selector(("dismiss")))
            
//            vc = UINavigationController(rootViewController: v)
            completion(viewController)
        }
    }
}
