//
//  UIViewController+Extension.swift
//  Pandalove
//
//  Created by dilipkumar on 24/04/19.
//  Copyright © 2019 dilipkumar. All rights reserved.
//

import UIKit

public extension UIDevice {
    
    public class var isPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    public class var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    public class var isTV: Bool {
        return UIDevice.current.userInterfaceIdiom == .tv
    }
    
    public class var isCarPlay: Bool {
        return UIDevice.current.userInterfaceIdiom == .carPlay
    }
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func topMostViewController() -> UIViewController {
        
        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }
        
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }
        
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostViewController() ?? tab
        }
        
        return self
    }
    
    func jsonValidate(jsonString:String)-> Bool {
    //        let userMetaJson = textViewuserMeta.text.replacingOccurrences(of: "”", with: "\"")
            
            guard let jsonDataToVerify = jsonString.data(using: String.Encoding.utf8)else {return false}
            
                do {
                    _ = try JSONSerialization.jsonObject(with: jsonDataToVerify)
                    return true
                } catch {
                    print("Error deserializing JSON: \(error.localizedDescription)")
                    return false
                }
            
            
        }
        func jsonToString(json: AnyObject)-> String?{
               do {
                   let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
                   let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
                   
                   print(convertedString ?? "defaultvalue")
                return convertedString
               } catch let myJSONError {
                   print(myJSONError)
                return nil
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
}

