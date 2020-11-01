//
//  AlertController.swift
//  MyEnrollment
//
//  Created by POORAN SUTHAR on 31/10/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    static func showAlert(message:String,title:String,vc: UIViewController ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alertController.addAction(action)
        vc.present(alertController, animated: true, completion: nil)
    }
}
