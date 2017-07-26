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
    
    var accountResponse: AccountResponse = AccountResponse(json: [:])
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let accessToken = UserDefaults.standard.accessToken else {
            return
        }
        
        FCApi.getAccount(accessToken: accessToken, categories: sections) { account, error in
            self.accountResponse = account
            DispatchQueue.main.async {
                self.accountResponse = account
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        self.tableView.register(cellNib: PersonalDataCell.self)
        self.tableView.register(cellNib: PublicProfileCell.self)
        self.tableView.register(cellNib: EmailCell.self)
        self.tableView.register(cellNib: PhoneCell.self)
        
        self.tableView.setEditing(true, animated: true)
        self.tableView.tableFooterView = UIView()
    }
   
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelEdit(_ sender: UIBarButtonItem) {
        dismiss()
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
        }
    }
    func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
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

extension RegistrationEditionViewController: UITableViewDataSource, UITableViewDelegate {
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
            if let emailCount = accountResponse.account?.emails.count {
                return emailCount
            }
            return 0
        case .Phones:
            if let phoneCount = accountResponse.account?.phones.count {
                return phoneCount
            }
            return 0
        case .Addresses:
            return 100
        case .Documents:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sections[indexPath.section] {
        case .PublicProfile:
            let cell: PublicProfileCell = self.tableView.dequeueReusableCell(for: indexPath)
            cell.nameField.text = accountResponse.account?.publicProfile?.name
            return cell
        case .PersonalData:
            let cell: PersonalDataCell = self.tableView.dequeueReusableCell(for: indexPath)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            
            if let birthdate = accountResponse.account?.personalData?.birthdate {
                cell.birthdateTextField.text = dateFormatter.string(from: birthdate)
            }
            
            cell.countryTextField.text = accountResponse.account?.personalData?.country
            
            if let dependents = accountResponse.account?.personalData?.dependentCount {
                cell.dependentsQtyTextField.text = "\(dependents)"
            }
            
            if let gender = accountResponse.account?.personalData?.genderTypeFriendlyName {
                cell.genderBtn.setTitle(gender, for: .normal)
            }
            
            cell.delegate = self
            return cell
        case .Emails:
            let cell: EmailCell = self.tableView.dequeueReusableCell(for: indexPath)
            let email = accountResponse.account?.emails[indexPath.row]
            cell.delegate = self
            cell.emailTextField.text = email?.address
            
            if let isPrimary = email?.isPrimary {
                let primaryText = isPrimary ? "Primary" : "Not Primary"
                cell.primaryBtn.setTitle(primaryText, for: .normal)
            }
            
            return cell
        case .Phones:
            let cell: PhoneCell = self.tableView.dequeueReusableCell(for: indexPath)
            let phone = accountResponse.account?.phones[indexPath.row]
            
            cell.delegate = self
            cell.phoneTypeBtn.setTitle(phone?.typeFriendlyName, for: .normal)
            cell.fullNumberTextField.text = phone?.fullNumber
            
            return cell
        case .Addresses:
            return tableView.dequeueReusableCell(withIdentifier: "")!
        case .Documents:
            return tableView.dequeueReusableCell(withIdentifier: "")!
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch sections[indexPath.section] {
        case .PublicProfile, .PersonalData:
            return false
        case .Emails, .Phones, .Addresses, .Documents:
            return true
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200.0
//    }
    
}

extension RegistrationEditionViewController: DataCellDelegate {
    
    func getActionSheetControllerToPresent(_ actionSheetController: UIAlertController) {
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func dismissPicker() {
        self.dismissKeyboard()
    }
}
