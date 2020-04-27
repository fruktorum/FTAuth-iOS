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

public enum PhoneMask: String {
    case none
    case x_xxx_xxx_xxxx = "+X (XXX) XXX-XXXX"
    case xx_xxx_xxx_xxxx = "+XX (XXX) XXX-XXXX"
}
