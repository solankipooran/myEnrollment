//
//  UsersViewController.swift
//  MyEnrollment
//
//  Created by POORAN SUTHAR on 31/10/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class UsersViewController: UIViewController {
    @IBOutlet weak var userTableView: UITableView!
    
    var userInformation = [User]()
    var hud = MBProgressHUD()
    
    let db = Database.database()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
        getdata()
    }
    
    func getdata() {
        ref = Database.database().reference(withPath: "User")
        ref.observe(DataEventType.value, with: { (snapshot) in
            guard let postDict = snapshot.value as? [String:Any] else {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            self.userInformation.removeAll()
            postDict.forEach { (key, value) in
                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let dataAsList = try decoder.decode(User.self, from: data)
                    self.userInformation.append(dataAsList)
                }
                catch let err {
                    AlertController.showAlert(message: err.localizedDescription, title: "Error", vc: self)
                }
            }
            DispatchQueue.main.async {
                self.hud.hide(animated: true)
                self.userTableView.reloadData()
            }
        })
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell", for: indexPath) as? UsersTableViewCell else {
            return UITableViewCell()
        }
        let user = userInformation.reversed()[indexPath.row]
        cell.configureCell(model: user)
        cell.deleteUserBtn.addTarget(self, action: #selector(deleterow(button:)), for: .touchUpInside)
        cell.deleteUserBtn.tag = indexPath.row
        return cell
    }
    
    @objc func deleterow(button : UIButton){
        let indexpath = IndexPath(row: button.tag, section: 0)
        ref.child(userInformation[button.tag].firstName).removeValue()
        userInformation.remove(at: button.tag)
        userTableView.beginUpdates()
        userTableView.deleteRows(at: [indexpath], with: .automatic)
        userTableView.endUpdates()
    }
}
