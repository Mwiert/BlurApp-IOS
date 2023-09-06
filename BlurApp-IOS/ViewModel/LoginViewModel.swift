//
//  LoginViewModel.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 30.12.2022.
//5005

import Foundation
import Alamofire
import SwiftyJSON

func convertDictionaryToString(_ dictionary: [String: Any]) -> String? {
    do {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        if let jsonString = String(data: jsonData, encoding: .utf8) {
            return jsonString
        }
    } catch {
        print("Error converting dictionary to string: (error)")
    }
    return nil
}

class userLoginVM: ObservableObject{

func userLoginReq(Email: String, Password: String, completion: @escaping (Bool) -> Void) {
        let paramJson: Dictionary = ["email": Email, "password": Password]
        let myObj = convertDictionaryToString(paramJson)
        
        
      AF.request(reqUrl().loginUrl, method: .post, parameters: myObj, encoder: JSONParameterEncoder.default, headers: apiService().reqHeaders).responseString{ response in
            switch response.result {
            case .success(let data):
                do {
                   var jsonString = data.replacingOccurrences(of: "\\\"", with: "\"") // Kaçış dizilerini düzgün hale getirin
                    jsonString = String(jsonString.dropFirst().dropLast()) // Çift tırnakları kaldırın

                    if let jsonData = jsonString.data(using: .utf8) {
                        do {
                            // Parse the JSON data into a dictionary
                            
                            if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                                
                                let AId = jsonDict["Id"] as? String
                                    print("Id: \(AId!)")
                                
                                
                                let AEmail = jsonDict["Email"] as? String
                                    print("Email: \(AEmail!)")
                                
                                
                                let APassword = jsonDict["Password"] as? String
                                    print("Password: \(APassword!)")
                                
                                
                                let AName = jsonDict["Name"] as? String
                                    print("Name: \(AName!)")
                                
                                
                                let ASurname = jsonDict["Surname"] as? String
                                    print("Surname: \(ASurname!)")
                                
                                
                                let AToken = jsonDict["Token"] as? String
                                    print("Token: \(AToken!)")
                                
                                
                                let ATokenExpiresIn = jsonDict["TokenExpiresIn"] as? String
                                    print("TokenExpiresIn: \(ATokenExpiresIn!)")
                                
                                
                                let AUserType = jsonDict["UserType"] as? Int
                                    print("UserType: \(AUserType!)")
                                
                                let myUser = userProps(id: AId!, email: AEmail!, password: APassword!, name: AName!, surname: ASurname!, token: AToken!, tokenExpiresIn: ATokenExpiresIn!, userType: AUserType!)
                                print(myUser)
                                userDefaultsOptions().saveLoginUserInfo(userInfoLogin: myUser)
                                completion(true)
                            }
                        } catch {
                            print("JSON parsing error: \(error.localizedDescription)")
                            completion(false)
                        }
                    }
                    } catch {
                        print("JSON çözme hatası: \(error.localizedDescription)")
                        completion(false)
                    }
               // İstek başarılı olduğunda true döndürün
            case .failure(let error):
                print(error.localizedDescription)
                userDefaultsOptions().userLogout()
                completion(false) // İstek başarısız olduğunda false döndürün
            }
        }
    }
}

