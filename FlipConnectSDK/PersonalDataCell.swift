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
    let locales = NSLocale.locales()
    
    @IBAction func updateBirthdate(_ sender: UITextField) {
        delegate?.runCommand()
    }
    
    @IBOutlet weak var birthdate: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dependentsQty: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBAction func genderWasTapped(_ sender: UIButton) {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
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
        
        let countryPickerView = UIPickerView()
        countryPickerView.showsSelectionIndicator = true
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        let pickerToolbarView = UIToolbar()
        pickerToolbarView.barStyle = UIBarStyle.default
        pickerToolbarView.isTranslucent = true
        pickerToolbarView.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PersonalDataCell.hidePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PersonalDataCell.cancelPicker))
        
        pickerToolbarView.setItems([cancelButton, spaceButton, doneButton], animated: false)
        pickerToolbarView.isUserInteractionEnabled = true
        
        countryTextField.inputView = countryPickerView
        countryTextField.inputAccessoryView = pickerToolbarView

    }
    
    func cancelPicker() {
        self.countryTextField.text = nil
        self.delegate?.dismissPicker()
    }
    
    func hidePicker() {
        self.delegate?.dismissPicker()
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
    
    func dismissPicker()
}

extension PersonalDataCell: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locales[row].countryName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.countryTextField.text = locales[row].countryName
    }
}
