//
//  EmailCell.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 20/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class EmailCell: UITableViewCell {

    var delegate: DataCellDelegate!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var primaryBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func primaryBtnWasTapped(_ sender: UIButton) {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let primaryActionButton = UIAlertAction(title: "Primary", style: .default) { action -> Void in
            sender.setTitle("Primary", for: .normal)
        }
        actionSheetController.addAction(primaryActionButton)
        
        let notPrimaryActionButton = UIAlertAction(title: "Not Primary", style: .default) { action -> Void in
            sender.setTitle("Not Primary", for: .normal)
        }
        actionSheetController.addAction(notPrimaryActionButton)
        
        delegate.getActionSheetControllerToPresent(actionSheetController)
    }
}
