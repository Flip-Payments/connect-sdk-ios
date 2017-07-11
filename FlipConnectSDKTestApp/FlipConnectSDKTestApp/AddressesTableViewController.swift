//
//  AddressesTableViewController.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 10/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class AddressesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200.0

        tableView.register(cellNib: AddressTableViewCell.self)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "addressCell") as! AddressTableViewCell
        let cell: AddressTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        // Configure the cell...
        cell.cityStateLbl.text = "Rio de Janeiro-RJ"
        cell.complementLbl.text = "Apto 303"
        cell.countryFlagLbl.text = "🇧🇷"
        cell.districtLbl.text = "Tijuca"
        cell.streetLbl.text = "Rua Conde de Bonfim, 803"
        cell.zipCodeLbl.text = "20270-101"
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    private func tableView(_ tableView: UITableView, willDisplay cell: AddressTableViewCell, forRowAt indexPath: IndexPath) {
        cell.cityStateLbl.text = "Rio de Janeiro-RJ"
        cell.complementLbl.text = "Apto 303"
        cell.countryFlagLbl.text = "🇧🇷"
        cell.districtLbl.text = "Tijuca"
        cell.streetLbl.text = "Rua Conde de Bonfim, 803"
        cell.zipCodeLbl.text = "20270-101"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
