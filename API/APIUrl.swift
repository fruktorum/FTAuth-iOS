//
//  APIUrl.swift
//  FTAuth
//
//  Created by Maria on 10.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

enum ServerType: String {
    
    #if DEBUG
    case auth = "http://localhost:3003"
    #else
    case auth = "2"
    #endif

}

let AUTH_SERVER_URL = "\(ServerType.auth.rawValue)"
