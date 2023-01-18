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
     let apiURL : String = "http://localhost:5208/"
    
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
    case userLoginPath = "api/home/login/" // method : POST
    case userRegisterPath = "api/home/createaccount/" // method POST
    case createWorkplace = "api/admin/createworkplace/" // method POST
    case getallWorkplaces = "api/user/getallworkplaces/" // method GET
    case createProfession = "api/admin/createprofession/" // method POST
    case createSingleProfession = "api/admin/createsingleprofession/" // method POST
    case getallProfessions = "api/user/getallprofessions/" // method GET
    case getnearestWorkPlaces = "api/user/getnearestworkplaces/" // method POST
}

struct reqUrl{
    let loginUrl = apiService().apiURL + requestPaths.userLoginPath.rawValue
    let registerUrl = apiService().apiURL + requestPaths.userRegisterPath.rawValue
    let createProfessionUrl = apiService().apiURL + requestPaths.createProfession.rawValue
    let createWorkplaceUrl = apiService().apiURL + requestPaths.createWorkplace.rawValue
    let getallWorkplacesUrl = apiService().apiURL + requestPaths.getallWorkplaces.rawValue
    let createSingleProfessionUrl = apiService().apiURL + requestPaths.createSingleProfession.rawValue
    let getallProfessionsUrl = apiService().apiURL + requestPaths.getallProfessions.rawValue
    let getnearestWorkPlacesUrl = apiService().apiURL + requestPaths.getnearestWorkPlaces.rawValue
}
