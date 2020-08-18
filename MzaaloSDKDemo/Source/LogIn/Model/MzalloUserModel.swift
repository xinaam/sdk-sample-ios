//
//  MzalloUserModel.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 18/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import Foundation

struct MzalloUserModel: Codable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone:String?
    var gender: String?
    var countryCode: String?
    var dob: String?
}

