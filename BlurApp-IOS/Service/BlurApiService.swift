//
//  BlurApiService.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 29.12.2022.
//

import Foundation
import Alamofire

public class apiService{
     let apiURL : String = "http://localhost:5208/"
    
    
    let reqHeaders: HTTPHeaders = [
        "accept" : "application/json",
        "Content-Type": "application/json"
    ]
    
// genel AF fonksiyonu yazılabilir.

}
enum requestPaths : String {
    case userLoginPath = "api/home/login/" // method : POST
    case userRegisterPath = "api/home/createaccount/" // method POST
    case createWorkplace = "api/user/createworkplace/" // method POST
    case getallWorkplaces = "api/user/getallworkplaces/" // method GET
    case createProfession = "api/user/createprofession/" // method POST
}
