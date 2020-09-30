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
        //param = ["email": "user@example.com"]
        textViewuserMeta.text = self.jsonToString(json: param as AnyObject)
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
        let userMetaJson = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
        if self.jsonValidate(jsonString: userMetaJson) {
            self.view.showLoader()
            let userMetaJson = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
            guard let userMeta: [String:String] = self.convertToDictionary(text: userMetaJson) else {return}
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
