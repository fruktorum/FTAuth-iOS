//
//  FTCheckerAcceptanceOfTerms.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTCheckerAcceptanceOfTerms: UIButton {
    
    // MARK: - Public Properties
    
    public var checked = false
    public var imageOn: UIImage? {
        didSet {
            updateImage()
        }
    }
    
    public var imageOff: UIImage? {
        didSet {
            updateImage()
        }
    }
    
    // MARK: - Properties
    
    var type = TypeElement.accept

    var isValid: Bool {
        if FTAuth.requiredElements.contains(type) {
            return checked
        } else {
            return true
        }
    }
    
    // MARK: - Methods
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        FTAuth.registrationCheckerAcceptanceOfTerms = self
        addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
        updateImage()
    }
    
    @objc private func touchUpInside(sender: UIButton) {
        checked = !checked
        updateImage()
    }
    
    private func updateImage() {
        if let imageOn = imageOn, let imageOff = imageOff {
            self.setImage(checked ? imageOn : imageOff , for: .normal)
        } else {
            self.tintColor = self.tintColor.withAlphaComponent(checked ? 1 : 0.3)
        }
    }
    
    func checkValid() {
        //место для добавления выделения невалидной кнопки
//        imageView?.layer.borderColor = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
//        imageView?.layer.borderWidth = checked ? 0 : 1
    }
    
    // MARK: - Public Methods
    
    public func set(checked: Bool, imageOn: UIImage, imageOff: UIImage) {
        self.checked = checked
        self.imageOn = imageOn
        self.imageOff = imageOff
        updateImage()
    }
}
