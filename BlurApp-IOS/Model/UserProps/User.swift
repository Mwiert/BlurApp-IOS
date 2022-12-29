//
//  User.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import Foundation

struct user : Codable{
    
    let id : UUID
    let email : String
    let password : String
    let name : String
    let surname : String
    let token : String
    let tokenExpiresIn : Date
}

