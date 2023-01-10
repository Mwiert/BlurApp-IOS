//
//  LoginViewModel.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 30.12.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class userLoginVM{
    func userLoginReq(Email: String, Password: String){
        
        let paramJson : JSON = ["email":"\(Email)","password":"\(Password)"]

        AF.request(reqUrl().loginUrl, method: .post ,parameters: paramJson ,encoder: JSONParameterEncoder.default,headers: apiService().reqHeaders).responseDecodable(of : userProps.self, completionHandler: { response in
              switch response.result {
              case .success(let data):
                  userDefaultsOptions().saveLoginUserInfo(userInfoLogin: data)
              print(data)
              case .failure(let error):
                  userDefaultsOptions().userLogout()
              print(error.localizedDescription)
              }
          })
    }
}

