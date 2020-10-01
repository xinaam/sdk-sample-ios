//
//  BaseViewController.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 18/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Function to show toast
     func showToast(message: String) {
         
         for view in self.view.subviews {
             if view.tag == 1000 {
                 view.removeFromSuperview()
             }
         }
         
         guard message.count > 0 else {
             return
         }
         
         let toastContainer = UIView(frame: CGRect())
         toastContainer.tag = 1000
        toastContainer.backgroundColor = .black
         toastContainer.alpha = 0.0
         toastContainer.layer.cornerRadius = 10
         toastContainer.clipsToBounds  =  true
         
         let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = .white
         toastLabel.textAlignment = .center;
        toastLabel.font = UIFont.systemFont(ofSize: 15)
         toastLabel.text = message
         toastLabel.clipsToBounds  =  true
         toastLabel.numberOfLines = 0
         
         toastContainer.addSubview(toastLabel)
         self.view.addSubview(toastContainer)
         
         toastLabel.translatesAutoresizingMaskIntoConstraints = false
         toastContainer.translatesAutoresizingMaskIntoConstraints = false
         
         let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 30)
         let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -30)
         let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
         let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
         toastContainer.addConstraints([a1, a2, a3, a4])
         
         let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .greaterThanOrEqual, toItem: self.view, attribute: .leading, multiplier: 1, constant: 40)
         let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -40)
         let c3 = NSLayoutConstraint(item: toastContainer, attribute: .centerY, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
         let c4 = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .lessThanOrEqual, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
         self.view.addConstraints([c1, c2, c3, c4])
         
         
         UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
             toastContainer.alpha = 1.0
         }, completion: { _ in
             UIView.animate(withDuration: 0.5, delay: 3.0, options: .curveEaseOut, animations: {
                 toastContainer.alpha = 0.0
             }, completion: {_ in
                 toastContainer.removeFromSuperview()
             })
         })
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
