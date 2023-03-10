//
//  dataStorage.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 18.01.2023.
//

import Foundation

public class dataStorage{
    
    func saveWorkplaceList(workplaces : [Workplace]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(workplaces) {
            UserDefaults.standard.set(encoded, forKey: "mainWorkplaces")
        }
    }
    func getWorkplaces() -> [Workplace]{
        
         let mainWorkplaces = UserDefaults.standard.object(forKey: "mainWorkplaces") as? Data
            let decoder = JSONDecoder()
        let loadedInfo = try? decoder.decode([Workplace].self, from: mainWorkplaces!)
            return loadedInfo!
    }
    func saveProfessions(professions : [professionInfo] ){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(professions) {
            UserDefaults.standard.set(encoded, forKey: "professions")
        }
    }
    func getProfessions() -> [professionInfo]{
        
         let mainWorkplaces = UserDefaults.standard.object(forKey: "professions") as? Data
            let decoder = JSONDecoder()
        let loadedInfo = try? decoder.decode([professionInfo].self, from: mainWorkplaces!)
            return loadedInfo!
    }
}
