//
//  AuthResponseModel.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 11.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import Foundation

public class AuthResponseModel: ResponseModel {
    public var provider_token: String?
    public var session_token: String?
    
    public func set(_ session_token: String?, _ provider_token: String?) {
        self.session_token = session_token
        self.provider_token = provider_token
        self.success = true
    }
}


public class ResponseModel: Decodable {
    public var success: Bool?
    public var errors: [FTErrorModel]?
}
