//
//  Workplace.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 29.12.2022.

import Foundation

// MARK: - Welcome
struct fullWorkplace: Codable {
    let workplace: Workplace
}

// MARK: - Workplace
struct Workplace: Codable {
    let id: ids
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


