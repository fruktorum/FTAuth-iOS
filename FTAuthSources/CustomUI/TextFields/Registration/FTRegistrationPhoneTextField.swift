//
//  FTRegistrationPhoneTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTRegistrationPhoneTextField: FTTextField {
    
    private var phoneMask: String?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        type = TypeElement.phone(nil)
        FTAuth.registrationPhoneTF = self
    }
    
    override func checkValid() -> Bool {
        text?.isValidPhone ?? false
    }
    
    override func checkDescriptionValidTextField() {
        descriptionLbl.isHidden = true
        if FTAuth.requiredElements.contains(type) {
            switch type {
            case .phone(let mask):
                phoneMask = mask?.rawValue
                print("phoneMask \(phoneMask)")
            default:  break
            }
            if text == nil || text == "" {
                descriptionLbl.text = "The phone cannot be blank"
                descriptionLbl.isHidden = false
            } else if !checkValid() {
                descriptionLbl.text = "Incorrect phone"
                descriptionLbl.isHidden = false
            }
        } else {
            guard (text != nil && text != "") else { return }
            if !checkValid() {
                descriptionLbl.text = "Incorrect phone"
                descriptionLbl.isHidden = false
            }
        }
    }
    
    private func formattedNumber(number: String) -> String {
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        guard let mask = phoneMask else { return number }
//        let mask = "+X (XXX) XXX-XXXX"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = formattedNumber(number: newString)
        return false
    }
}

