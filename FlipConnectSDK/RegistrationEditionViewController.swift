//
//  RegistrationEditionViewController.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 23/06/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class RegistrationEditionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        let nib = UINib(nibName: "PersonalDataCell", bundle: Bundle(for: PersonalDataCell.self))
        self.tableView.register(nib, forCellReuseIdentifier: "PersonalDataCell")
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

extension RegistrationEditionViewController: UITableViewDataSource, UITableViewDelegate, PersonalDataCellDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalDataCell") as! PersonalDataCell
        cell.delegate = self
        
        cell.test()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200.0
//    }
    
    func runCommand() {
        print("ghy")
    }
}
