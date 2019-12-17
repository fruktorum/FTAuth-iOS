//
//  FTTextFieldDelegate.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 12.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? FTTextField {
            textField.checkValidTextField()
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? FTTextField {
            textField.cleanTextFieldDescription()
        }
    }
}
