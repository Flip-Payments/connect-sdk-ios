//
//  AddressesTableViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 10/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit
import FlipConnectSDK

class AddressesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var addresses: AddressesResponse = AddressesResponse(json: [:])
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let publicToken = UserDefaults.standard.publicToken, let accountKey = UserDefaults.standard.accountKey else {
            return
        }
        
        FCApi.getAddresses(publicToken: publicToken, accountKey: accountKey) { addresses, error in
            self.addresses = addresses
            DispatchQueue.main.async {
                self.addresses = addresses
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0

        tableView.register(cellNib: AddressTableViewCell.self)
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.addresses.addresses.count
        return numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddressTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        let address = self.addresses.addresses[indexPath.row]
        
        // Configure the cell...
        cell.cityStateLbl.text = "\(address.city!) - \(address.state!)"
        cell.complementLbl.text = address.complement
        cell.countryFlagLbl.text = address.country == "BR" ? "🇧🇷" : address.country
        cell.districtLbl.text = address.district
        cell.streetLbl.text = "\(address.street!), \(address.number!)"
        cell.zipCodeLbl.text = address.zipCode
        

        return cell
    }
}
