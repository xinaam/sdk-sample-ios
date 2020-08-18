//
//  Constants.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 18/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import Foundation
import UIKit

struct Validation {
    static let name = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
    static let email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    static let number = "0123456789"
}

/*
 App constants
 */
struct Constants {
    static let screenHeight : CGFloat = UIScreen.main.bounds.height
    static let screenWidth : CGFloat = UIScreen.main.bounds.width
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let networkStoryboard:UIStoryboard = UIStoryboard(name: "Networks", bundle: nil)
    
}
