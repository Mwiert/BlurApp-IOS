//
//  Workplace.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 29.12.2022.

import Foundation

// MARK: - Welcome
struct fullWorkplace: Codable {
    let Workplace: Workplace
}

// MARK: - Workplace
struct Workplace: Codable {
    let id: ID
    let professionName, name: String
    let location: Location
    
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: String
    
}

struct createWorkplace : Codable{
    let name : String?
    let latitude : String?
    let longitude : String?
    let professionName : String?
}

struct location2 : Codable {
    let latitude  : Double?
    let longitude : Double?


}

struct Workplace2: Codable {
    let id: ID
    let professionName, name: String
    let location : location2

}

