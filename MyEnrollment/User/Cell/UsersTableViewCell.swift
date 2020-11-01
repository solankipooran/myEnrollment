//
//  UsersTableViewCell.swift
//  MyEnrollment
//
//  Created by POORAN SUTHAR on 31/10/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteUserBtn: UIButton!
    @IBOutlet weak var userDescriptionlabel: UILabel!
    @IBOutlet weak var userNamelabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(model:User) {
        userProfileImage.clipsToBounds = true
        userProfileImage.layer.cornerRadius = 25
        userNamelabel.text = "\(model.firstName) \(model.lastName)"
        userDescriptionlabel.text = "\(model.gender)|\(model.dateOfBirth)|\(model.stateName)"
        if let data = Data(base64Encoded: model.imageString) {
            self.userProfileImage.image = UIImage(data: data)
        }
    }
}

