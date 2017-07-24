//
//  DataCellDelegate.swift
//  FlipConnectSDK
//
//  Created by Munir Wanis on 24/07/17.
//  Copyright © 2017 Flip Connect. All rights reserved.
//

import Foundation

protocol DataCellDelegate {
    func getActionSheetControllerToPresent(_ actionSheetController: UIAlertController)
    
    func dismissPicker()
}
