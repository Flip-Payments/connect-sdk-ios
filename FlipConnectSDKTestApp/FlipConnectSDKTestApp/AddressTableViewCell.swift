//
//  AddressTableViewCell.swift
//  FlipConnectSDKTestApp
//
//  Created by Munir Wanis on 10/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var complementLbl: UILabel!
    @IBOutlet weak var districtLbl: UILabel!
    @IBOutlet weak var cityStateLbl: UILabel!
    @IBOutlet weak var zipCodeLbl: UILabel!
    @IBOutlet weak var countryFlagLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.streetLbl.text = "adasdsdas"
        self.complementLbl.text = "apartamento 123"
        self.districtLbl.text = "tjk"
        self.cityStateLbl.text = "rio - rj"
        self.zipCodeLbl.text = "12345-222"
        self.countryFlagLbl.text = "🇧🇷"
    }

}
