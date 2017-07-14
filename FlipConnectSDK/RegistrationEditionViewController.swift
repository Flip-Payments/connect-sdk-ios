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
    
    var sections: [FCEditCategoriesEnum] = []
    
    var user: UserResponse = UserResponse(json: [:])
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let accessToken = UserDefaults.standard.accessToken else {
            return
        }
        
        FCApi.getUser(accessToken: accessToken) { user, error in
            self.user = user
            DispatchQueue.main.async {
                self.user = user
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        let personalDataCellNib = UINib(nibName: "PersonalDataCell", bundle: Bundle(for: PersonalDataCell.self))
        self.tableView.register(personalDataCellNib, forCellReuseIdentifier: "PersonalDataCell")
        
        let publicProfileCellNib = UINib(nibName: "PublicProfileCell", bundle: Bundle(for: PublicProfileCell.self))
        self.tableView.register(publicProfileCellNib, forCellReuseIdentifier: "PublicProfileCell")
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
        switch sections[section] {
        case .PublicProfile:
            return "Public Profile"
        case .PersonalData:
            return "Personal Data"
        case .Emails:
            return "Emails"
        case .Phones:
            return "Phones"
        case .Addresses:
            return "Addresses"
        case .Documents:
            return "Documents"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .PublicProfile:
            return 1
        case .PersonalData:
            return 1
        case .Emails:
            return 100
        case .Phones:
            return 100
        case .Addresses:
            return 100
        case .Documents:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sections[indexPath.section] {
        case .PublicProfile:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PublicProfileCell") as! PublicProfileCell
            cell.nameField.text = user.user?.publicProfile?.name
            return cell
        case .PersonalData:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PersonalDataCell") as! PersonalDataCell
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if let birthdate = user.user?.personalData?.birthdate {
                cell.birthdate.text = dateFormatter.string(from: birthdate)
            }
            
            cell.delegate = self
            cell.test()
            return cell
        case .Emails:
            return tableView.dequeueReusableCell(withIdentifier: "")!
        case .Phones:
            return tableView.dequeueReusableCell(withIdentifier: "")!
        case .Addresses:
            return tableView.dequeueReusableCell(withIdentifier: "")!
        case .Documents:
            return tableView.dequeueReusableCell(withIdentifier: "")!
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200.0
//    }
    
    func runCommand() {
        print("ghy")
    }
}
