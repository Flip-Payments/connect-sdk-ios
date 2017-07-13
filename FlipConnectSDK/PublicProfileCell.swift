//
//  PublicProfileCell.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 13/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class PublicProfileCell: UITableViewCell {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var pictureImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
