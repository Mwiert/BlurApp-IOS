//
//  Coordinates.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 13.01.2023.
//

import Foundation

struct CoordinatesStruct : Codable{
    let topLeftCorner : topLeft
    let bottomRightCorner : bottomRight
}

struct topLeft : Codable{
    let latitude : String
    let longitde : String
}
struct bottomRight : Codable{
    let latitude : String
    let longitde : String
}
