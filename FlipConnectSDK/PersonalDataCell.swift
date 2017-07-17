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
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dependentsQty: UITextField!
    @IBOutlet weak var country: UITextField!
    
    @IBAction func genderWasTapped(_ sender: UIButton) {
        let actionSheetController = UIAlertController(title: "Gender", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let feminineActionButton = UIAlertAction(title: GenderType.feminine.rawValue, style: .default) { action -> Void in
            sender.setTitle(GenderType.feminine.rawValue, for: .normal)
        }
        actionSheetController.addAction(feminineActionButton)
        
        let masculineActionButton = UIAlertAction(title: GenderType.masculine.rawValue, style: .default) { action -> Void in
            sender.setTitle(GenderType.masculine.rawValue, for: .normal)
        }
        actionSheetController.addAction(masculineActionButton)
        
        let unmentionedActionButton = UIAlertAction(title: GenderType.unmentioned.rawValue, style: .default) { action -> Void in
            sender.setTitle(GenderType.unmentioned.rawValue, for: .normal)
        }
        actionSheetController.addAction(unmentionedActionButton)
        
        delegate?.getActionSheetControllerToPresent(actionSheetController)
    }
    
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
    
    func getActionSheetControllerToPresent(_ actionSheetController: UIAlertController)
}
