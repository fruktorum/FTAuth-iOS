//
//  FTAuthFacebookBtn.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 27.01.2020.
//  Copyright © 2020 Fruktorum. All rights reserved.
//

import WebKit

public class FTAuthFacebookBtn: BaseWebViewButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        url = "\(AUTH_SERVER_URL)/facebook?mobile=true"
    }
}
