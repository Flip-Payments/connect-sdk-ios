//
//  PersonalDataCell.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 13/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import UIKit

class PersonalDataCell: UITableViewCell {
    
    var delegate: DataCellDelegate!
    let locales = NSLocale.locales()
    
    @IBOutlet weak var birthdateTextField: UITextField!
    @IBOutlet weak var genderBtn: UIButton!
    @IBOutlet weak var dependentsQtyTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    
    @IBAction func genderWasTapped(_ sender: UIButton) {
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let feminineActionButton = UIAlertAction(title: GenderType.feminine.rawValue.capitalized, style: .default) { action -> Void in
            sender.setTitle(GenderType.feminine.rawValue.capitalized, for: .normal)
        }
        actionSheetController.addAction(feminineActionButton)
        
        let masculineActionButton = UIAlertAction(title: GenderType.masculine.rawValue.capitalized, style: .default) { action -> Void in
            sender.setTitle(GenderType.masculine.rawValue.capitalized, for: .normal)
        }
        actionSheetController.addAction(masculineActionButton)
        
        let unmentionedActionButton = UIAlertAction(title: GenderType.unmentioned.rawValue.capitalized, style: .default) { action -> Void in
            sender.setTitle(GenderType.unmentioned.rawValue.capitalized, for: .normal)
        }
        actionSheetController.addAction(unmentionedActionButton)
        
        delegate.getActionSheetControllerToPresent(actionSheetController)
    }
    
    func datePickerValueChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // yyyy-MM-dd
        
        let dateString = formatter.string(from: sender.date)
        
        self.birthdateTextField.text = dateString
    }
    
    var expandedHeight: CGFloat { get { return 350 } }
    var defaultHeight: CGFloat { get { return 180 } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // MARK: Setting pickerToolbarView to pickers
        
        let pickerToolbarView = UIToolbar()
        pickerToolbarView.barStyle = UIBarStyle.default
        pickerToolbarView.isTranslucent = true
        pickerToolbarView.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PersonalDataCell.hidePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PersonalDataCell.cancelPicker))
        
        pickerToolbarView.setItems([cancelButton, spaceButton, doneButton], animated: false)
        pickerToolbarView.isUserInteractionEnabled = true
        
        // MARK: Setting pickerView to countryTextField
        
        let countryPickerView = UIPickerView()
        countryPickerView.showsSelectionIndicator = true
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        
        self.countryTextField.inputView = countryPickerView
        self.countryTextField.inputAccessoryView = pickerToolbarView
        
        // MARK: Setting datePickerView to birthdateTextField
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        
        self.birthdateTextField.inputView = datePicker
        self.birthdateTextField.inputAccessoryView = pickerToolbarView
    }
    
    func cancelPicker() {
        self.delegate.dismissPicker()
    }
    
    func hidePicker() {
        self.delegate.dismissPicker()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
