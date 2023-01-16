//
//  RegisterViewModel.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 30.12.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class userRegisterVM{
    //2 kez girmek zorunda kalıyor.
    func userRegisterReq(Email: String, Password: String,Name : String, Surname: String){
        
        let paramRegister : JSON = ["email":"\(Email)","password":"\(Password)","name":"\(Name)","surname":"\(Surname)"]
        
        AF.request(reqUrl().registerUrl, method: .post ,parameters: paramRegister ,encoder: JSONParameterEncoder.default,headers: apiService().reqHeaders).responseDecodable(of : mainUser.self, completionHandler: { response in
              switch response.result {
              case .success(let data):
                  userDefaultsOptions().saveRegisterUserInfo(userInfoRegister: data)
              case .failure(_):
                  userDefaultsOptions().userLogout()
              }
          })
      
    }
    
}
