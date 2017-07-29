//
//  UserViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 07/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit
import FlipConnectSDK

class UserViewController: UIViewController {
    @IBOutlet weak var publicProfileNameLbl: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    
    @IBAction func editAction(_ sender: Any) {
        let categories: [FCEditCategoriesEnum] = [.Emails, .PublicProfile, .PersonalData, .Phones]
        
        FCEditUser.loadView(categories: categories) { viewController in
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let publicToken = UserDefaults.standard.publicToken, let accountKey = UserDefaults.standard.accountKey else {
            return
        }
        
        FCApi.getUser(publicToken: publicToken, accountKey: accountKey, categories: [.Emails]) { user, error in
            DispatchQueue.main.async {
                self.publicProfileNameLbl.text = user.user?.publicProfile?.name
                self.emailAddress.text = user.user?.emails.first?.address
            }
            print(user.user?.publicProfile?.name ?? "oops")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
