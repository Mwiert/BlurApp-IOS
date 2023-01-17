//
//  RegisterViewModel.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 30.12.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class userRegisterVM : ObservableObject{
    
    func userRegisterReq(Email: String, Password: String,Name : String, Surname: String) async throws -> Bool{
        
        let paramRegister : JSON = ["email":"\(Email)","password":"\(Password)","name":"\(Name)","surname":"\(Surname)"]
        
        let request = AF.request(reqUrl().registerUrl, method: .post, parameters: paramRegister, encoder: JSONParameterEncoder.default, headers: apiService().reqHeaders).serializingDecodable(mainUser.self)
        
        switch await request.response.result {
              case .success(let data):
                  userDefaultsOptions().saveRegisterUserInfo(userInfoRegister: data)
            return true
              case .failure(_):
                  userDefaultsOptions().userLogout()
            return false
              }
    }
    
}
