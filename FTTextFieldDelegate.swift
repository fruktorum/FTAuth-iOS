//
//  FTTextFieldDelegate.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 12.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

class FTTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let textField = textField as? FTTextField {
            textField.checkDescriptionValidTextField()
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let textField = textField as? FTTextField {
            textField.cleanTextFieldDescription()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
