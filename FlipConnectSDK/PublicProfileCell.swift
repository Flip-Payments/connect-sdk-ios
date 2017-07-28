//
//  PublicProfileCell.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 13/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class PublicProfileCell: UITableViewCell {
    
    var delegate: DataCellDelegate!
    
    var publicProfilePatchRequest: PublicProfilePatchRequest? = nil

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var pictureImage: UIImageView!
    
    @IBAction func nameDidEndEditing(_ sender: UITextField) {
        publicProfileWillInstantiate()
        
        if sender.text == nil || sender.text!.isEmpty {
            self.publicProfilePatchRequest!.add(operation: .remove, path: .name)
        } else {
            self.publicProfilePatchRequest!.add(operation: .replace, path: .name, value: sender.text)
        }
        self.delegate.addPublicProfileToPatch(self.publicProfilePatchRequest!)
    }
    
    func publicProfileWillInstantiate() {
        if self.publicProfilePatchRequest == nil {
            self.publicProfilePatchRequest = PublicProfilePatchRequest()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
