//
//  MzaaloUserModel.swift
//  MzaaloSDKDemo
//
//  Created by Admin on 18/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import Foundation

struct MzaaloUserModel: Codable {
    var id: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone:String?
    var gender: String?
    var countryCode: String?
    var dob: String?
    
    func toJSONString()->String{
        do{
            let user = MzaaloUserModel(id: id, firstName: firstName, lastName: lastName, email: email, phone: phone, gender: gender, countryCode: countryCode, dob: dob)
            let jsonData = try JSONEncoder().encode(user)
                let jsonString = String(data: jsonData, encoding: .utf8)!
                return jsonString
        }catch let error{
            print("exception\(error)")
        }
        return ""
    }
}

