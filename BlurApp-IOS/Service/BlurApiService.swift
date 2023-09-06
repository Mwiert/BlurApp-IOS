//
//  BlurApiService.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 29.12.2022.
//

import Foundation
import Alamofire
import SwiftyJSON

public class apiService{
    let apiURL : String = "http://localhost:5005/api/"  // 5208 idi
    let apiUserUrl : String = "http://localhost:5084/api/"
    let apiWpUrl : String = "http://localhost:5238/"
    // /localhost:5005/api/Authentication/login
    
    
    func headerWithToken() -> HTTPHeaders{
        let token = userDefaultsOptions().getUserInfo().token!
        let headerWithToken: HTTPHeaders = [
            .authorization(bearerToken: token),
            .accept("application/json"),
            .contentType("application/json")
        ]
        return headerWithToken
    }
    let reqHeaders: HTTPHeaders = [
        "accept" : "application/json",
        "Content-Type": "application/json"
    ]
    
    
// genel AF fonksiyonu yazılabilir.

}

enum requestPaths : String {
    case userLoginPath = "Authentication/login2" // method : POST
    case userRegisterPath = "Authentication/createaccount/" // method POST
    case createWorkplace = "admin/createworkplace/" // method POST
    case getallWorkplaces = "user/getallworkplaces" // method GET
    case createProfession = "admin/createprofession/" // method POST
    case createSingleProfession = "admin/createsingleprofession/" // method POST
    case getallProfessions = "user/getallprofessions" // method GET
    case getnearestWorkPlaces = "user/getnearestworkplaces/" // method POST
}

struct reqUrl{
    let loginUrl = apiService().apiURL + requestPaths.userLoginPath.rawValue
    let registerUrl = apiService().apiURL + requestPaths.userRegisterPath.rawValue
    let createProfessionUrl = apiService().apiURL + requestPaths.createProfession.rawValue
    let createWorkplaceUrl = apiService().apiURL + requestPaths.createWorkplace.rawValue
    let getallWorkplacesUrl = apiService().apiWpUrl + requestPaths.getallWorkplaces.rawValue
    let createSingleProfessionUrl = apiService().apiURL + requestPaths.createSingleProfession.rawValue
    let getallProfessionsUrl = apiService().apiWpUrl + requestPaths.getallProfessions.rawValue
    let getnearestWorkPlacesUrl = apiService().apiURL + requestPaths.getnearestWorkPlaces.rawValue
}
