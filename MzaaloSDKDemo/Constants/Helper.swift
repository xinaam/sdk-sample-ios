//
//  Helper.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 17/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {
    
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
//
//        if let delegate = UIApplication.shared.delegate as? AppDelegate {
//            delegate.orientationLock = orientation
//        }
//    }
//
//    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
//    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
//
//        self.lockOrientation(orientation)
//
//        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
//    }
    
}

//MARK: - get Response Messages
func getResponseMessage(res: Any) -> String {
    guard let response = res as? [String:Any] else {
        return ""
    }
    if let msg = response["message"] as? String {
        return msg
    }
    else{
        return ""
    }
}
//--------------------------------------------------------------------------------------------------------------------


struct Country {
    let country_code: String!
    let country_name: String!
    let dialling_code: String!
    
    init(param: Dictionary<String,Any>) {
        country_code = param["country_code"] as? String ?? ""
        country_name = param["country_name"] as? String ?? ""
        dialling_code = param["dialling_code"] as? String ?? ""
    }
}

func getCountryCodeListsArray() -> [Country] {
    var result = [Country]()
    if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [[String:Any]] {
                // do stuff
                
                for item in jsonResult {
                    result.append(Country.init(param: item))
                }
            }
        } catch {
            // handle error
        }
    }
    
    return result
}


/*func getAppListsArray(partition: Int) -> [[AppLists]] {
    var result = [[AppLists]]()
    
    if let path = Bundle.main.path(forResource: "talent", ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
            if let jsonResult = jsonResult as? [[String:Any]] {
                // do stuff
                var tempArray = [AppLists]()
                
                for item in jsonResult {
                    tempArray.append(AppLists.init(param: item))
                }
                
                var partitionCount = partition
                var partitionIndex = 0
                let count = (jsonResult.count / partition) + (tempArray.count % partition > 0 ? 1:0)
                for _ in 0..<count {
                    var array = [AppLists]()
                    for j in partitionIndex..<partitionCount {
                        if tempArray.count > j {
                            array.append(tempArray[j])
                        }
                    }
                    partitionCount = partitionCount + partition
                    partitionIndex = partitionIndex + partition
                    result.append(array)
                }
            }
        } catch {
            // handle error
        }
    }
    
    return result
}*/






func convertDictionaryToJson(param: [String:Any]) -> String {
    if let theJSONData = try?  JSONSerialization.data(
        withJSONObject: param,
        options: .prettyPrinted
        ),
        let theJSONText = String(data: theJSONData,
                                 encoding: String.Encoding.ascii) {
        return theJSONText
    }
    return ""
}
func convertJsonToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return nil
}

func isIphone() -> Bool {
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    // 2. check the idiom
    switch (deviceIdiom) {
    case .phone:
        return true
    default:
        return false
    }
}

func getFontSize(FontSize: CGFloat) -> CGFloat {
    var size: CGFloat = 0
    
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    // 2. check the idiom
    switch (deviceIdiom) {
    case .phone:
        size = Constants.screenWidth / FontSize
    default:
        size = Constants.screenWidth / (FontSize*1.5)
    }
    
    return size
}

func getCurrentTimeZone() -> String {
    return TimeZone.current.identifier
}

//MARK: - Notification Set
func NotificationSet(observer:Any,notificationName:String,selector:Selector){
    NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: notificationName), object: nil)
    NotificationCenter.default.addObserver(observer, selector: selector, name: NSNotification.Name(rawValue: notificationName), object: nil)
}
//--------------------------------------------------------------------------------------------------------------------

//MARK: - Notification Triger
func NotificationTriger(notificationName:String,response:[String:Any]){
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationName), object: nil, userInfo: response)
}
//--------------------------------------------------------------------------------------------------------------------

//MARK: - Notification Remove
func NotificationRemove(observer:Any,notificationName:String){
    NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: notificationName), object: nil)
}
//--------------------------------------------------------------------------------------------------------------------


extension UINavigationController {
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.filter({$0.isKind(of: ofClass)}).last {
            popToViewController(vc, animated: animated)
        }
    }
    
    func popViewControllers(viewsToPop: Int, animated: Bool = true) {
        if viewControllers.count > viewsToPop {
            let vc = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(vc, animated: animated)
        }
    }
    
}
