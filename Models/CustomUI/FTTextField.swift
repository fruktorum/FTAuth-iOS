//
//  FTTextField.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 12.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTTextField: UITextField {
    
    public var descriptionLbl = UILabel()
    
    public var verticalLocationOfDescription: CGFloat? {
        didSet {
            setConstraints()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = FTAuth.textFieldDelegate
        descriptionLbl.font = self.font
        descriptionLbl.textColor = .red
        descriptionLbl.textAlignment = .left
        setConstraints()
        self.addSubview(descriptionLbl)
    }
            
    func setConstraints() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = NSLayoutConstraint(item: descriptionLbl,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: self,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: descriptionLbl,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: self,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: verticalLocationOfDescription ?? self.frame.height)
        let widthConstraint = NSLayoutConstraint(item: descriptionLbl,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: self.frame.width)
        let heightConstraint = NSLayoutConstraint(item: descriptionLbl,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: self.frame.height)
        self.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
        
    
    
    func checkValidTextField() {
        setConstraints()
        let text = "The field cannot be empty"
        self.descriptionLbl.text = text
        self.descriptionLbl.isHidden = !(self.text?.isEmpty ?? true)
    }
    
    func cleanTextFieldDescription() {
        self.descriptionLbl.isHidden = true
    }
}

public class FTEmailTextField: FTTextField {
    
    override func checkValidTextField() {
        FTAuth.emailTextField = self
        let text = "Incorrect email"
        self.descriptionLbl.text = text
        self.descriptionLbl.isHidden = self.text?.isValidEmail ?? false
    }
}
public class FTPasswordTextField: FTTextField {
    override func checkValidTextField() {
        FTAuth.passwordTextField = self
        let text = "The password cannot be blank"
        self.descriptionLbl.text = text
        self.descriptionLbl.isHidden = !(self.text?.isEmpty ?? true)
    }
}
//class FTConfirmPasswordTextField: FTTextField {
//    override func checkValidTextField() {
//        let text = "Incorrect email"
//        self.topDescription?.text = text
//        self.bottomDescription?.text = text
//        self.topDescription?.isHidden = self.text?.isValidEmail ?? false
//        self.bottomDescription?.isHidden = self.text?.isValidEmail ?? false
//    }
//}
