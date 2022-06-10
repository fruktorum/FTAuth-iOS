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
    var leadingConstraint = NSLayoutConstraint()
    var heightConstraint = NSLayoutConstraint()
    var type = TypeElement.none
    var isValid: Bool {
        if FTAuth.requiredElements.contains(type) {
            return checkValid()
        } else {
            return true
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = FTAuth.viewModel.textFieldDelegate
        settingDescriptionLbl()
    }

    func checkValid() -> Bool {
        (text != nil && text != "")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = FTAuth.viewModel.textFieldDelegate
        settingDescriptionLbl()
    }
    
    func settingDescriptionLbl(_ textColor: UIColor? = nil,
                              _ font: UIFont? = nil,
                              _ textAlignment: NSTextAlignment? = nil,
                              _ backgroundColor: UIColor? = nil,
                              _ attributedText: NSAttributedString? = nil,
                              _ lineBreakMode: NSLineBreakMode? = nil,
                              _ adjustsFontSizeToFitWidth: Bool? = nil,
                              _ minimumScaleFactor: CGFloat? = nil,
                              _ numberOfLines: Int? = nil,
                              _ highlightedTextColor: UIColor? = nil,
                              _ isHighlighted: Bool? = nil,
                              _ shadowColor: UIColor? = nil,
                              _ shadowOffset: CGSize? = nil) {
        descriptionLbl.textColor = textColor == nil ? .red : textColor
        descriptionLbl.font = font == nil ? self.font?.withSize(10) : font
        descriptionLbl.textAlignment = textAlignment ?? .left
        descriptionLbl.backgroundColor = backgroundColor ?? .clear
        descriptionLbl.attributedText = attributedText
        descriptionLbl.lineBreakMode = lineBreakMode ?? descriptionLbl.lineBreakMode
        descriptionLbl.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth ?? descriptionLbl.adjustsFontSizeToFitWidth
        descriptionLbl.minimumScaleFactor = minimumScaleFactor ?? descriptionLbl.minimumScaleFactor
        descriptionLbl.numberOfLines = numberOfLines ?? 1
        descriptionLbl.highlightedTextColor = highlightedTextColor
        descriptionLbl.isHighlighted = isHighlighted ?? descriptionLbl.isHighlighted
        descriptionLbl.shadowColor = shadowColor
        descriptionLbl.shadowOffset = shadowOffset ?? descriptionLbl.shadowOffset
        addSubview(descriptionLbl)
        addConstraints()
    }
            
    func addConstraints() {
        descriptionLbl.translatesAutoresizingMaskIntoConstraints = false
        horizontalConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        setVerticalLocationOfDescription(nil)
        leadingConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        heightConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 10)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, leadingConstraint, heightConstraint])
    }
    
    func checkDescriptionValidTextField() {
        descriptionLbl.text = "The field cannot be empty"
        descriptionLbl.isHidden = !(text?.isEmpty ?? true)
    }
    
    func cleanTextFieldDescription() {
        descriptionLbl.isHidden = true
    }
    
    //MARK: - Public Methods
    
    public func setVerticalLocationOfDescription(_ verticalLocationOfDescription: CGFloat?) {
        NSLayoutConstraint.deactivate([verticalConstraint])
        var verticalLocation = frame.height/2 + 10
        if let verticalLocationOfDescription = verticalLocationOfDescription {
            verticalLocation = verticalLocationOfDescription
        } else if let verticalLocationOfDescription = FTAuth.generalVerticalLocationOfDescription {
            verticalLocation = verticalLocationOfDescription
        }
        verticalConstraint = NSLayoutConstraint(item: descriptionLbl, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: verticalLocation)
        NSLayoutConstraint.activate([verticalConstraint])
    }
}
