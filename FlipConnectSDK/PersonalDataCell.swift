//
//  PersonalDataCell.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 13/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class PersonalDataCell: UITableViewCell {
    
    var delegate: PersonalDataCellDelegate?
    
    @IBAction func updateBirthdate(_ sender: UITextField) {
        delegate?.runCommand()
    }
    
    @IBOutlet weak var birthdate: UITextField!

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: sender.date)
        
        self.birthdate.text = dateString
    }
    
    var expandedHeight: CGFloat { get { return 350 } }
    var defaultHeight: CGFloat { get { return 180 } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate?.runCommand()

    }
    
    func test() {
        delegate?.runCommand()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol PersonalDataCellDelegate {
    
    func runCommand()
    
}
