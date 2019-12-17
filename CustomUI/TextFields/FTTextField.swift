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
    var horizontalConstraint = NSLayoutConstraint()
    var verticalConstraint = NSLayoutConstraint()
    var widthConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = FTAuth.textFieldDelegate
        descriptionLbl.font = self.font
        descriptionLbl.textColor = .red
        descriptionLbl.textAlignment = .left
        self.addSubview(descriptionLbl)
        addConstraints()
    }
            
    func addConstraints() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        setVerticalLocationOfDescription(nil)
        widthConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.frame.width)
        heightConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.frame.height)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    public func setVerticalLocationOfDescription(_ verticalLocationOfDescription: CGFloat?) {
        NSLayoutConstraint.deactivate([verticalConstraint])
        verticalConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: verticalLocationOfDescription ?? self.frame.height/2 + 10)
        NSLayoutConstraint.activate([verticalConstraint])
    }
    
    func checkValidTextField() {
        self.descriptionLbl.text = "The field cannot be empty"
        self.descriptionLbl.isHidden = !(self.text?.isEmpty ?? true)
    }
    
    func cleanTextFieldDescription() {
        self.descriptionLbl.isHidden = true
    }
}
