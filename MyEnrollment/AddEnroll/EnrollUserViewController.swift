//
//  EnrollUserViewController.swift
//  MyEnrollment
//
//  Created by POORAN SUTHAR on 31/10/20.
//  Copyright © 2020 POORAN SUTHAR. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift

class EnrollUserViewController: UIViewController {
        
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var firstNameTxtField: UITextField!
    @IBOutlet weak var lastNameTxtField: UITextField!
    @IBOutlet weak var genderTxtField: UITextField!
    @IBOutlet weak var countryTxtField: UITextField!
    @IBOutlet weak var stateTxtField: UITextField!
    @IBOutlet weak var homeTownTxtField: UITextField!
    @IBOutlet weak var phoneNumberTxtField: UITextField!
    @IBOutlet weak var telePhoneNumberTxtField: UITextField!
    @IBOutlet weak var dateOfBirthTxtField: UITextField!
        
    var imagePicker = UIImagePickerController()
    
    let genderPicker = UIPickerView()
    let genderOption = ["Male","Female","Others"]
    
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    
    let db = Database.database()
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImage.layer.cornerRadius = 40
        userImage.clipsToBounds = true
        setGenderPicker()
        setDobPicker()
        setupTextField()
        ref = db.reference(withPath: "User")
    }
    
    @IBAction func selectUserImageBtnAction(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) || UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func addUserBtnaction(_ sender: Any) {
        if validate(){
            resetAll()
            AlertController.showAlert(message: "Successfully Registered", title: "Congrats", vc: self)
        } else {
            AlertController.showAlert(message: "Something is Missing", title: "Missing Inforamtion", vc: self)
        }
    }
    
    func validate() -> Bool {
        if let firstName = firstNameTxtField.text,
            let lastname = lastNameTxtField.text,
            let gender = genderTxtField.text,
            let dob = dateOfBirthTxtField.text,
            let countryName = countryTxtField.text,
            let stateName = stateTxtField.text,
            let homeTownName = homeTownTxtField.text,
            let phoneNumber = phoneNumberTxtField.text,
            let telePhone = telePhoneNumberTxtField.text,
            let imageUser = userImage.image{
            if telePhone.count != 10 || phoneNumber.count != 10 {
                return false
            } else {
                if let imageString = imageUser.jpegData(compressionQuality: 0.2)?.base64EncodedString() {
                    let data = ["firstName": firstName, "lastName": lastname, "dateOfBirth":dob , "countryName": countryName, "gender": gender, "stateName": stateName, "homeTownName": homeTownName, "telePhone": telePhone, "phoneNumber": phoneNumber, "imageString": imageString]
                    ref.child(firstName).setValue(data)
                }
                return true
            }
        }
        return false
    }
    
    func resetAll() {
        firstNameTxtField.text = ""
        lastNameTxtField.text = ""
        genderTxtField.text = ""
        dateOfBirthTxtField.text = ""
        countryTxtField.text = ""
        stateTxtField.text = ""
        homeTownTxtField.text = ""
        phoneNumberTxtField.text = ""
        telePhoneNumberTxtField.text = ""
    }
    
    func setupTextField() {
        firstNameTxtField.changeBorderColor()
        lastNameTxtField.changeBorderColor()
        countryTxtField.changeBorderColor()
        genderTxtField.changeBorderColor()
        telePhoneNumberTxtField.changeBorderColor()
        phoneNumberTxtField.changeBorderColor()
        homeTownTxtField.changeBorderColor()
        stateTxtField.changeBorderColor()
        dateOfBirthTxtField.changeBorderColor()
    }
    
    func setDobPicker(){
        datePicker.datePickerMode = .date
        dateOfBirthTxtField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        dateOfBirthTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTapped))
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateOfBirthTxtField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func doneTapped() {
        dateOfBirthTxtField.text = dateFormatter.string(from: datePicker.date)
    }
    
    func setGenderPicker() {
        genderPicker.dataSource = self
        genderPicker.delegate = self
        genderTxtField.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(doneTappedOnGender))
        genderTxtField.inputView = genderPicker
    }
    
    @objc func doneTappedOnGender() {
        genderTxtField.text = genderOption[genderPicker.selectedRow(inComponent: 0)]
    }
}


extension EnrollUserViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] else {
            return
        }
        dismiss(animated: true) {
            self.userImage.image = image as? UIImage
        }
    }
}

extension EnrollUserViewController: UIPickerViewDataSource,UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTxtField.text = genderOption[row]
    }
}

