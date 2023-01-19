//
//  LoginViewModel.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 30.12.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class userLoginVM: ObservableObject{
    func userLoginReq(Email: String, Password: String) async throws -> Bool{
        
        let paramJson : JSON = ["email":"\(Email)","password":"\(Password)"]
        
        let request = AF.request(reqUrl().loginUrl,method: .post,parameters: paramJson,encoder: JSONParameterEncoder.default,headers: apiService().reqHeaders).serializingDecodable(userProps.self)
    
        switch await request.response.result {
        case .success(let data):
            userDefaultsOptions().saveLoginUserInfo(userInfoLogin: data)
            return true
        case .failure(let error):
            print(error.localizedDescription)
            userDefaultsOptions().userLogout()
            return false
        }
        
     /*   AF.request(reqUrl().loginUrl, method: .post ,parameters: paramJson ,encoder: JSONParameterEncoder.default,headers: apiService().reqHeaders).responseDecodable(of : userProps.self, completionHandler: { response in
              switch response.result {
              case .success(let data):
                  userDefaultsOptions().saveLoginUserInfo(userInfoLogin: data)
              print(data)
              case .failure(let error):
                  userDefaultsOptions().userLogout()
              print(error.localizedDescription)
              }
          })*/
    }
}

