//
//  RegistrationEditionViewController.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 23/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class RegistrationEditionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelEdit(_ sender: UIBarButtonItem) {
        dismiss()
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
