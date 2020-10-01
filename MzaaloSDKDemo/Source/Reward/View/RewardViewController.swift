//
//  RewardViewController.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 17/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import UIKit
import DropDown
import MzaaloSDK
import MzaaloRewardsSDK

class RewardViewController: BaseViewController {

    @IBOutlet weak var labelBalance: UILabel!
    @IBOutlet weak var textViewEvent: UITextView!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonRewardsContent: UIButton!
    @IBOutlet weak var textFeildEvent: UITextField!
    @IBOutlet weak var textFeildRewardActions: UITextField!
    @IBOutlet weak var menuButton: UIButton!
    
    var data:[String] = ["CONTENT_VIEWED","CHECKED_IN","SIGNED_UP","REFERRAL_APPLIED"]
    var dropDown = DropDown()
    let placeholderText = "Enter JSONObject of EventMeta"
    var menus = ["LoggedInUser"]
    let menuDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func configUI(){
        self.hideKeyboardWhenTappedAround()
        textFeildEvent.delegate = self
        textViewEvent.text = placeholderText
        textFeildRewardActions.rightViewMode = .always
        let viewImage = UIImageView.init(image: UIImage.init(named: "down-arrow"))
        viewImage.tintColor = UIColor.label
        textFeildRewardActions.rightView = viewImage
        dropDown.anchorView = buttonRewardsContent
        dropDown.dataSource = data
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.textFeildRewardActions.text = item
        }
        self.textFeildRewardActions.text = "SIGNED_UP"
        dropDown.width = textFeildRewardActions.frame.width
        
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
    
    //   API for Reward Registration in Mzaalo
    func registerReward(){
        let jsonstring = textFeildEvent.text?.replacingOccurrences(of: "”", with: "\"", options: [.caseInsensitive, .regularExpression])//replacingOccurrences(of: "”", with: "\"")
        
        if self.jsonValidate(jsonString: jsonstring!) || textFeildEvent.text?.isEmpty ?? true {
            self.view.showLoader()
            var rewardAction: MzaaloRewardsAction!
            if textFeildRewardActions.text ?? "" == "SIGNED_UP"{
                rewardAction = MzaaloRewardsAction.signedUp
            }else if textFeildRewardActions.text ?? "" == "CHECKED_IN"{
                rewardAction = MzaaloRewardsAction.checkedIn
            }else if textFeildRewardActions.text ?? "" == "CONTENT_VIEWED"{
                rewardAction = MzaaloRewardsAction.contentViewed
            }else {
                rewardAction = MzaaloRewardsAction.referralApplied
            }
            DispatchQueue.main.async {
                let eventMetaJson = self.textFeildEvent.text?.replacingOccurrences(of: "”", with: "\"")
                var eventMeta: [String:String] = [:]
                if self.textFeildEvent.text?.isEmpty ?? true {
                    eventMeta = [:]
                    
                }else {
                    eventMeta = self.convertToDictionary(text: eventMetaJson!)!
                }
                print(eventMeta)
                Mzaalo.sharedInstance.registerRewardAction(action: rewardAction , eventMeta: eventMeta, onSuccess: {
                    print("Reward Registered Successfully")
                    DispatchQueue.main.async {
                        self.view.hideLoader()
                        self.showToast(message: "Registered Successfully")
                    }
                    
                }) { (err) in
                    print(err)
                    DispatchQueue.main.async {
                        self.view.hideLoader()
                        self.showToast(message: err.debugDescription)
                    }
                    
                }
            }
        }else {
            showToast(message: "Provide valid JSONObject")
        }
    }
    
//   API for Get Balance form mzaalo
    func getBalance(){
        DispatchQueue.main.async {
            Mzaalo.sharedInstance.getBalance(onSuccess: { (balance:Int) in
               
                print("balance \(balance)")
                DispatchQueue.main.async {
                    self.labelBalance.text = "Balance : \(balance)"
                    self.view.hideLoader()
                }
                
            }, onFailure: { (err:String) in
                print(err)
                DispatchQueue.main.async {
                  self.view.hideLoader()
                    self.showToast(message: err.debugDescription)
                }
                
            })
        }
    }
    
    @IBAction func buttonRewardAction(_ sender: UIButton) {
        dropDown.show()
    }
    
    @IBAction func buttonregisterAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.registerReward()
        }
    }
    
    @IBAction func buttonFetchReward(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.view.showLoader()
            self.getBalance()
        }
    }
    
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension RewardViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tempStr = textField.text!
        let str = "\\"
        let tempJsonstring = tempStr.replacingOccurrences(of: "”", with: "\"", options: [.caseInsensitive, .regularExpression])//replacingOccurrences(of: "”", with: "\"")
        let tempJson = tempJsonstring.replace(string: "”", replacement: "\"")
        let jsonstring = tempJson.replacingOccurrences(of: str, with: "")
        textField.text! = jsonstring
        return true
    }
}
