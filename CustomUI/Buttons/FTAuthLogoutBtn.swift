//
//  FTAuthLogoutBtn.swift
//  FTAuth
//
//  Created by Герасимов Тимофей Владимирович on 17.12.2019.
//  Copyright © 2019 Fruktorum. All rights reserved.
//

import UIKit

public class FTAuthLogoutBtn: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addTarget(self, action: #selector(touchUpInside), for: UIControl.Event.touchUpInside)
    }
    
    @objc func touchUpInside(sender: UIButton) {
        superview?.endEditing(true)
        let alert = UIAlertController(title: "Sign out", message: "Do you really want to sign out?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Sign out", style: UIAlertAction.Style.default, handler: { _ in
            FTAuth.logout()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        let vc = UIApplication.shared.windows.first?.rootViewController
        vc?.present(alert, animated: true, completion: nil)
    }
}
