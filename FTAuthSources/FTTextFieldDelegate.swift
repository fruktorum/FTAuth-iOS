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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let phoneField = textField as? FTRegistrationPhoneTextField {
            print("FTTextFieldDelegate shouldChangeCharactersIn")
            return phoneField.textField(phoneField, shouldChangeCharactersIn: range, replacementString: string)
//            guard let text = textField.text else { return false }
//            let newString = (text as NSString).replacingCharacters(in: range, with: string)
//            textField.text = textField.formattedNumber(number: newString)
//            return false
        }
        print(6)
        return false//
    }
}
