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
    var reqURL = apiService().apiURL + requestPaths.userLoginPath.rawValue
    
    func userLoginReq(Email: String, Password: String) {

        let paramJson : JSON = ["email":"\(Email)","password":"\(Password)"]
        
        AF.request(reqURL, method: .post ,parameters: paramJson ,encoder: JSONParameterEncoder.default,headers: apiService().reqHeaders).responseDecodable(of : userProps.self, completionHandler: { response in
              switch response.result {
              case .success(let data):
              print(data)
                  // veritutulacak
              case .failure(let error):
              print(error.localizedDescription)
              }
          })
    }
    
}

