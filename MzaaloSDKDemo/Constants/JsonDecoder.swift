//
//  JsonDecoder.swift
//  MzaaloSDKDemo
//
//  Created by sathya on 18/08/20.
//  Copyright © 2020 Xfinite. All rights reserved.
//

import Foundation

let Decoder = JSONDecoder()
let Encoder = JSONEncoder()

//Decode the data response from api call
func fastDecode<input,result:Codable>(input:input , resultType : result.Type) -> result?{
    Decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601) //If the param contains date - Can specify the date formatte.
    let data = convertObject(value: input)
    do{
        let datavalue = try Decoder.decode(result.self, from: data)
        return datavalue //return array or dict
    }
    catch (let error){
        print(error) //If error
    }
    return nil
}

func fastEncode<input:Codable>(model:input)-> [String:Any] {
    do {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let a =  try encoder.encode(model) //encode the struct model to json - For passing as param in api call
        let json = try JSONSerialization.jsonObject(with: a, options: []) as! [String:Any]
        return json
    } catch {
        print(error) //If error
    }
    return [String:Any]()
}


func saveUserInfo<input:Codable>(model:input,infoKey:String){
    do{ //Save the struct object in user default.Struct type defined in generic
        let data = try PropertyListEncoder().encode(model) //Encode the struct data
        UserDefaults.standard.set(data, forKey: infoKey)
        UserDefaults.standard.synchronize()
    }
    catch (let error){
        print(error) //If error
    }
}

func fetchUserInfo<Result:Codable>() -> Result?{
    //Fetch the response as struct model from user default.Struct type defined in generic
    let encoded = UserDefaults.standard.object(forKey: "UserInfoKey") as! Data
    let userInfo = try! PropertyListDecoder().decode(Result.self, from: encoded)
    return userInfo
}


func convertObject<T>(value:T) -> Data{
    
    //Convert dictionary to data
    let innerJson = value as! [String:Any]
    var data = Data()
    do{
        data =  try! JSONSerialization.data(withJSONObject: innerJson , options:.prettyPrinted)
    }
    return data
}

extension DateFormatter { //Date formate while converting from json to object.
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
