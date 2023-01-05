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
    var reqURL = apiService().apiURL + requestPaths.userRegisterPath.rawValue
    
    func userRegisterReq(Email: String, Password: String,Name : String, Surname: String){
        
        let paramRegister : JSON = ["email":"\(Email)","password":"\(Password)","name":"\(Name)","surname":"\(Surname)"]
        
        AF.request(reqURL, method: .post ,parameters: paramRegister ,encoder: JSONParameterEncoder.default,headers: apiService().reqHeaders).responseDecodable(of : mainUser.self, completionHandler: { response in
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
