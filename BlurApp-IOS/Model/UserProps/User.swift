//
//  User.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import Foundation

struct mainUser : Codable{
    let user : userProps?
}

struct userProps : Codable {
    let id : ids
    let email : String?
    let password : String?
    let name : String?
    let surname : String?
    let token : String?
    let tokenExpiresIn : String?
    let userType : Int?
}

struct ids: Codable{
    let timestamp : Double?
    let machine : Double?
    let pid : Double?
    let increment : Double?
    let creationTime : String?
}


struct userLogin : Codable{
    let email : String?
    let password : String?
}
