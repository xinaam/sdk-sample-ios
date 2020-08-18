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
    @IBOutlet weak var textFeildEnvironMent: UITextField!
    @IBOutlet weak var textFeildPostalCode: UITextField!
    var arrowArray = ["Staging","Production"]
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUi()
        // Do any additional setup after loading the view.
    }
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
        textFeildEnvironMent.text = "Staging"
        textFeildPostalCode.text = "eros"
    }
    func moveToLogin(){
        DispatchQueue.main.sync {
            if let ctrl = storyboard?.instantiateViewController(identifier: "LoginViewController")as? LoginViewController {
                navigationController?.pushViewController(ctrl, animated: true)
            }
        }
        
    }
    func initializeSdk(){
        var environMent: MzaaloEnvironment!
        if textFeildEnvironMent.text == "Staging"{
            environMent = MzaaloEnvironment.STAGING
        }else{
            environMent = MzaaloEnvironment.PRODUCTION
        }
        Mzaalo.sharedInstance.setupSDK(partnerCode: textFeildPostalCode.text ?? "", environment: environMent, onSuccess: {
            print("success")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
