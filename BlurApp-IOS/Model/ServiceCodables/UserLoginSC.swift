//
//  UserLoginSC.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 4.01.2023.
//

import Foundation

struct userLogin : Codable {
    let email : String
    let password : String
}

/*func getUserConvert2Json(struct : userLogin){
    
    let jsonEncoder = JSONEncoder()
    let jsonData = try jsonEncoder.encode(userLogin)
    
}
*/
