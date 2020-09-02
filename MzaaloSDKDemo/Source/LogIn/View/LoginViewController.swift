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
        param = ["email": "shiva@gmail.com"]
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
    //MARK:- API for Method for Login user using SDK.
    func LoginSdk(){
        if jsonValidate() {
            self.view.showLoader()
            let userMetaJson = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
            guard let userMeta: [String:String] = convertToDictionary(text: userMetaJson) else {return}
            print(userMeta)
        Mzaalo.sharedInstance.login(userId: textFeildUniqueID.text ?? "", userMeta: userMeta, onSuccess: { (user) in
            
//            Encoding MazalloUser codedable Object
            print("MzaaloUser \(user)")
            let data = fastEncode(model: user)
            let objData = MzalloUserModel.init(id: data["id"]as? String ?? "", firstName: data["firstName"]as? String ?? "", lastName: data["lastName"]as? String ?? "", email: data["email"]as? String ?? "", phone: data["phone"]as? String ?? "", gender: data["gender"]as? String ?? "", countryCode: data["country_code"]as? String ?? "", dob: data["dob"]as? String ?? "")
           
            
            self.moveToProfile(data: objData)
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
        }else {
            showToast(message: "Provide valid JSONObject")
        }
    }
   
//    MARK:- Actions
    @IBAction func buttonLoginAction(_ sender: UIButton) {
        
        LoginSdk()
    }
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func jsonValidate()-> Bool {
//        let userMetaJson = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
        let jsonString = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
        guard let jsonDataToVerify = jsonString.data(using: String.Encoding.utf8)else {return false}
        
            do {
                _ = try JSONSerialization.jsonObject(with: jsonDataToVerify)
                return true
            } catch {
                print("Error deserializing JSON: \(error.localizedDescription)")
                return false
            }
        
        
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
    func convertToDictionary(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
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
extension LoginViewController: UITextViewDelegate {
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        var string = text
//        if text == "”"{
//            string = text.replace(string: "”", replacement: "\"")
//        }
//    }
}
