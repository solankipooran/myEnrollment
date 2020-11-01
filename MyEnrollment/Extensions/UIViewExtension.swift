//
//  TextFieldExtension.swift
//  MyEnrollment
//
//  Created by POORAN SUTHAR on 31/10/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func changeBorderColor() {
        let color1: UIColor = UIColor(red: 51/256, green: 110/256, blue: 157/256, alpha: 1)
        self.layer.borderColor = color1.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
    }
}


