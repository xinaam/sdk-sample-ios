//
//  LoginViewController.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 17/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import UIKit
import MzaaloSDK

class LoginViewController: BaseViewController {

    @IBOutlet weak var textFeildUserMeta: PaddingTextField!
    @IBOutlet weak var textFeildUniqueID: PaddingTextField!
    @IBOutlet weak var textViewuserMeta: UITextView!
    var param: [String:Any] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
//    MARK:- Functions
    func configUI(){
        self.hideKeyboardWhenTappedAround()
        textFeildUniqueID.text = "123"
//        textFeildUserMeta.text = "shivam@gmail.com"
        param = ["email": "shivam@gmail.com"]
        jsonToString(json: param as AnyObject)
    }
    func moveToProfile(data: MzalloUserModel){
        DispatchQueue.main.async {
            if let ctrl = self.storyboard?.instantiateViewController(identifier: "ProfileViewController")as? ProfileViewController{
                ctrl.user = data
                self.navigationController?.pushViewController(ctrl, animated: true)
                
            }
        }
        
    }
    func LoginSdk(){
        
        Mzaalo.sharedInstance.login(userId: textFeildUniqueID.text ?? "", userMeta: ["email":"shivam@gmail.com"], onSuccess: { (user) in
            
            
            let data = fastEncode(model: user)
            let objData = MzalloUserModel.init(id: data["id"]as? String ?? "", firstName: data["firstName"]as? String ?? "", lastName: data["lastName"]as? String ?? "", email: data["email"]as? String ?? "", phone: data["phone"]as? String ?? "", gender: data["gender"]as? String ?? "", countryCode: data["countryCode"]as? String ?? "", dob: data["dob"]as? String ?? "")
           
            
            self.moveToProfile(data: objData)
            DispatchQueue.main.async {
              self.view.hideLoader()
            }
        }) { (err) in
            print(err)
            DispatchQueue.main.async {
            self.showToast(message: err.debugDescription)
            }
        }
    }
   
//    MARK:- Actions
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        self.view.showLoader()
        LoginSdk()
    }
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func jsonToString(json: AnyObject){
           do {
               let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
               let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
               self.textViewuserMeta.text = convertedString ?? ""
               print(convertedString ?? "defaultvalue")
           } catch let myJSONError {
               print(myJSONError)
           }

       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
