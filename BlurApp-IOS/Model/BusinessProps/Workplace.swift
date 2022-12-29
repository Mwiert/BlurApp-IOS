//
//  Workplace.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 29.12.2022.
//

import Foundation


struct Workplace : Codable {
    let id : UUID
    let professionId : String
    let name : String
    let location : Location
}
