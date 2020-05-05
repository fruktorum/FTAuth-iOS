//
//  Constants.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 10.01.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import Foundation

public enum TypeElement: Equatable {
    case none
    
    
    case name
    case firstName
    case lastName
    case email
    case password
    case confirmPassword
    case phone
    case accept
}

public enum PhoneMask {
    case none
    case x_xxx_xxx_xxxx
    case xx_xxx_xxx_xxxx
    case plus
    case customMask(mask: String)
    
    var mask: String {
        switch self {
        case .x_xxx_xxx_xxxx: return "+X (XXX) XXX-XXXX"
        case .xx_xxx_xxx_xxxx: return "+XX (XXX) XXX-XXXX"
        case .plus: return "+XXXXXXXXXXXXXXXXXXXX"
        case .customMask(let customMask): return customMask
        case .none: return ""
        }
    }
}
