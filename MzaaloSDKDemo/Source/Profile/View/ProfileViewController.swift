//
//  ProfileViewController.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 17/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import UIKit
import MzaaloSDK

class ProfileViewController: UIViewController {

    @IBOutlet weak var textViewAccessToken: UITextView!
    @IBOutlet weak var labelDOB: UILabel!
    @IBOutlet weak var labelGender: UILabel!
    @IBOutlet weak var labelCountryCode: UILabel!
    @IBOutlet weak var labelPhone: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var labelFirstName: UILabel!
    var user: MzalloUserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        configUi()
        // Do any additional setup after loading the view.
    }
    
//    MARK:- Functions
    func configUi(){
        labelEmail.text = user?.email ?? ""
        labelDOB.text = user?.dob ?? ""
        labelPhone.text = user?.phone ?? ""
        labelLastName.text = user?.lastName ?? ""
        labelGender.text = user?.gender ?? ""
        labelCountryCode.text = user?.countryCode ?? ""
        labelFirstName.text = user?.firstName ?? ""
        textViewAccessToken.text = user?.id ?? ""
    }
    func moveToPlayerScreen(){
        if let ctrl = storyboard?.instantiateViewController(identifier: "VideoPlayerViewController")as? VideoPlayerViewController{
            ctrl.userId = user?.id ?? ""
            navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    @IBAction func buttonLogoutAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            Mzaalo.sharedInstance.logOut()
            self.moveToInitial()
        }
        
    }
    func moveToInitial(){
        if let ctrl = storyboard?.instantiateViewController(identifier: "InitialViewController")as? InitialViewController{
                   navigationController?.pushViewController(ctrl, animated: true)
               }
    }
    func moveToRewardScreen(){
       if let ctrl = storyboard?.instantiateViewController(identifier: "RewardViewController")as? RewardViewController{
            navigationController?.pushViewController(ctrl, animated: true)
        }
    }
//    MARK:- Actions
    @IBAction func buttonBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonGoToPlayer(_ sender: UIButton) {
       // moveToPlayerScreen()
    }
    @IBAction func buttonRewardsAction(_ sender: UIButton) {
        moveToRewardScreen()
    }
    

}
