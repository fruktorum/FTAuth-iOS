//
//  FTErrorModel.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 07.05.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import Foundation

public struct FTErrorModel: Decodable {
    public var key: String?
    public var message: String?
}
