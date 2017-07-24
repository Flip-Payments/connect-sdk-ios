//
//  PhoneCell.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 24/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class PhoneCell: UITableViewCell {
    var delegate: DataCellDelegate!
    
    @IBOutlet weak var phoneTypeBtn: UIButton!
    @IBOutlet weak var fullNumberTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func phoneTypeBtnPressed(_ sender: UIButton) {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let homeActionButton = UIAlertAction(title: PhoneType.home.rawValue.capitalized, style: .default) { action -> Void in
            sender.setTitle(PhoneType.home.rawValue.capitalized, for: .normal)
        }
        actionSheetController.addAction(homeActionButton)
        
        let mobileActionButton = UIAlertAction(title: PhoneType.mobile.rawValue.capitalized, style: .default) { action -> Void in
            sender.setTitle(PhoneType.mobile.rawValue.capitalized, for: .normal)
        }
        actionSheetController.addAction(mobileActionButton)
        
        let workActionButton = UIAlertAction(title: PhoneType.work.rawValue.capitalized, style: .default) { action -> Void in
            sender.setTitle(PhoneType.work.rawValue.capitalized, for: .normal)
        }
        actionSheetController.addAction(workActionButton)
        
        delegate.getActionSheetControllerToPresent(actionSheetController)
    }
}
