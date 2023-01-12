//
//  getWorkplaces.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 12.01.2023.
//

import Foundation

// MARK: - GetWorkplaces
struct GetWorkplaces: Codable {
    let id: ID
    let professionId, name: String
    let location: Locations

    enum CodingKeys: String, CodingKey {
        case id
        case professionId
        case name, location
    }
}

// MARK: - ID
struct ID: Codable {
    let timestamp, machine, pid, increment: Int
    let creationTime: String
}

// MARK: - Location
struct Locations: Codable {
    let latitude, longitude: String
}
