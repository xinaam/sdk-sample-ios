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
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var buttonRewardsContent: UIButton!
    @IBOutlet weak var textFeildEvent: UITextField!
    @IBOutlet weak var textFeildRewardActions: UITextField!
    var data:[String] = ["CONTENT_VIEWED","CHECKED_IN","SIGNED_UP","REFERRAL_APPLIED"]
    var dropDown = DropDown()
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }
    func configUI(){
        self.hideKeyboardWhenTappedAround()
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
        
    }
    //   API for Reward Registration in Mzaalo
    func registerReward(){
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
            Mzaalo.sharedInstance.registerRewardAction(action: rewardAction , eventMeta: [:], onSuccess: {
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
            self.view.showLoader()
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
