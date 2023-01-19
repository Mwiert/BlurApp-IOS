//
//  Coordinates.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 13.01.2023.
//

import Foundation

struct CoordinatesStruct : Codable{
    let topLeft : lats
    let bottomRight : lats
}

/*struct topLeftC : Codable{
    let latitude : String
    let longitude : String
}*/
struct lats : Codable{
    let latitude : String
    let longitude : String
}

