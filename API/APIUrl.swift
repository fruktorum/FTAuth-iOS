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
    case auth = "http://3.16.215.202:3001"
    #else
    case auth = ""
    #endif

}

let AUTH_SERVER_URL = "\(ServerType.auth.rawValue)"


