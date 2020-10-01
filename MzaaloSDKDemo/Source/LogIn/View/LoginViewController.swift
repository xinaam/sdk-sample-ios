//
//  LoginViewController.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 17/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import UIKit
import MzaaloSDK
import DropDown

class LoginViewController: BaseViewController {

    @IBOutlet weak var textFeildUserMeta: PaddingTextField!
    @IBOutlet weak var textFeildUniqueID: PaddingTextField!
    @IBOutlet weak var textViewuserMeta: UITextView!
    @IBOutlet weak var menuButton: UIButton!
    
    var param: [String:Any] = [:]
    let menuDropDown = DropDown()
    var menus = ["LoggedInUser"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
//    MARK:- Functions
    func configUI(){
        self.hideKeyboardWhenTappedAround()
        textFeildUniqueID.text = "123"
        //param = ["email": "shiva@gmail.com"]
        param = ["email": "user@example.com"]
        textViewuserMeta.text = self.jsonToString(json: param as AnyObject)
        
        //menu config
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
        if let user = getLoggedInUser(){
            showToast(message: user.toJSONString())
        }else{
            showToast(message: "null")
        }
    }
    
    func moveToProfile(data: MzaaloUserModel){
        DispatchQueue.main.async {
            if let ctrl = self.storyboard?.instantiateViewController(identifier: "ProfileViewController")as? ProfileViewController{
                ctrl.user = data
                self.navigationController?.pushViewController(ctrl, animated: true)
            }
        }
    }
    
    //MARK:- API for Method for Login user using SDK.
    func loginSDK(){
        let userMetaJson = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
        if self.jsonValidate(jsonString: userMetaJson) {
            self.view.showLoader()
            let userMetaJson = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
            guard let userMeta: [String:String] = self.convertToDictionary(text: userMetaJson) else {return}
            print(userMeta)
        Mzaalo.sharedInstance.login(userId: textFeildUniqueID.text ?? "", userMeta: userMeta, onSuccess: { (user) in
            DispatchQueue.main.async {
              self.view.hideLoader()
            }
//            Encoding MazalloUser codedable Object
            print("MzaaloUser \(user)")
            if let loggedInUser = self.getLoggedInUser(){
                self.moveToProfile(data: loggedInUser)
            }
        }) { (err) in
            print(err)
            DispatchQueue.main.async {
            self.view.hideLoader()
            self.showToast(message: err.debugDescription)
            }
        }
        }else {
            showToast(message: "Provide valid JSONObject")
        }
    }
   
//    MARK:- Actions
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        loginSDK()
    }
    
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension LoginViewController: UITextViewDelegate {
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        var string = text
//        if text == "”"{
//            string = text.replace(string: "”", replacement: "\"")
//        }
//    }
}
