//
//  InitialViewController.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 17/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import UIKit
import DropDown
import MzaaloSDK

class InitialViewController: BaseViewController {

    @IBOutlet weak var buttonInitialize: UIButton!
    @IBOutlet weak var buttonEnvironMent: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var textFeildEnvironMent: UITextField!
    @IBOutlet weak var textFeildPostalCode: UITextField!
    
    var arrowArray = ["STAGING","PRODUCTION"]
    var menus = ["LoggedInUser"]
    let dropDown = DropDown()
    let menuDropDown = DropDown()
    var environMent: MzaaloEnvironment = .STAGING
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUi()
    }
    
    //    MARK:- Functions
    //    Config UI
    func configUi(){
        self.hideKeyboardWhenTappedAround()
        textFeildEnvironMent.rightViewMode = .always
        let viewImage = UIImageView.init(image: UIImage.init(named: "down-arrow"))
        viewImage.tintColor = UIColor.label
        textFeildEnvironMent.rightView = viewImage
        dropDown.anchorView = buttonEnvironMent
        dropDown.dataSource = arrowArray
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.textFeildEnvironMent.text = item
        }
        dropDown.width = textFeildEnvironMent.frame.width - 10
        textFeildEnvironMent.text = "STAGING"
        textFeildPostalCode.text = "eros"
        
        menuDropDown.anchorView = menuButton
        menuDropDown.dataSource = menus
        menuDropDown.width = 200
        menuButton.addTarget(self, action: #selector(show(sender:)), for: .touchUpInside)
        menuDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            showLoggedInUser()
        }
    }
    
    @objc
    func show(sender:UIButton){
        menuDropDown.show()
    }
    
    func showLoggedInUser(){
        loginSDK()
    }
    
    func moveToLogin(){
        DispatchQueue.main.sync {
            if let ctrl = storyboard?.instantiateViewController(identifier: "LoginViewController")
                as? LoginViewController {
                navigationController?.pushViewController(ctrl, animated: true)
            }
        }
    }
    
    //MARK:- API for Initilizing setup Envirimnemnt and SDK
    func initializeSdk(){
        textFeildPostalCode.resignFirstResponder()
        if textFeildEnvironMent.text == "STAGING"{
            environMent = MzaaloEnvironment.STAGING
        }else{
            environMent = MzaaloEnvironment.PRODUCTION
        }
        Mzaalo.sharedInstance.setupSDK(partnerCode: textFeildPostalCode.text ?? "", environment: environMent, onSuccess: {
            print("Mzallo SDK initialized succesfully")
            self.moveToLogin()
            DispatchQueue.main.async {
              self.view.hideLoader()
            }
        
        }) { (err) in
            print(err)
             DispatchQueue.main.async {
            self.view.hideLoader()
            self.showToast(message: err.debugDescription)
            }
        }

    }
    
    @IBAction func buttonEnvironMentAction(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func buttonInitializeaction(_ sender: UIButton) {
        self.view.showLoader()
        DispatchQueue.main.async {
            self.initializeSdk()
        }
    }
}

//API integration
extension InitialViewController{
    func loginSDK(){
        let param = ["email": "user@example.com"]
        Mzaalo.sharedInstance.login(userId: "123", userMeta: param, onSuccess: { (user) in
            DispatchQueue.main.async {
              self.view.hideLoader()
            }
//            Encoding MazalloUser codedable Object
            let data = fastEncode(model: user)
            let objData = MzalloUserModel.init(id: data["id"]as? String ?? "", firstName: data["firstName"]as? String ?? "", lastName: data["lastName"]as? String ?? "", email: data["email"]as? String ?? "", phone: data["phone"]as? String ?? "", gender: data["gender"]as? String ?? "", countryCode: data["country_code"]as? String ?? "", dob: data["dob"]as? String ?? "")
                DispatchQueue.main.async {
                    self.showToast(message: objData.toJSONString())
                }
        }) { (err) in
            print(err)
            DispatchQueue.main.async {
            self.view.hideLoader()
            self.showToast(message: err.debugDescription)
            }
        }
    }
}
