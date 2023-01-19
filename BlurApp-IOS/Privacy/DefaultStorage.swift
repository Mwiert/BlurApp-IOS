//
//  DefaultStorage.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 4.01.2023.
//

import Foundation
import CoreLocation

public class userDefaultsOptions{
    
    func saveLoginUserInfo(userInfoLogin : userProps){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userInfoLogin) {
            UserDefaults.standard.set(encoded, forKey: "userInfo")
        }
    }
    
    func saveRegisterUserInfo(userInfoRegister : mainUser){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userInfoRegister) {
            UserDefaults.standard.set(encoded, forKey: "userInfo")
        }
    }
    
    func getUserInfo() -> userProps{
        let user = userProps.init(id: .init(timestamp: 1, machine: 1, pid: 1, increment: 1, creationTime: ""), email: "not found", password: "", name: "", surname: "", token: "", tokenExpiresIn: "",userType: 3)
        
        if let userInfo = UserDefaults.standard.object(forKey: "userInfo") as? Data  {
            let decoder = JSONDecoder()
            let loadedInfo = try? decoder.decode(userProps.self, from: userInfo)
            return loadedInfo!
        }
        else{
            return user
        }
    }
    
    func userLogout(){
            guard let domain = Bundle.main.bundleIdentifier else { return }
            UserDefaults.standard.removePersistentDomain(forName: domain)
            UserDefaults.standard.synchronize()
    }
    
    func saveisLogin(isLogon : String){
        let isLogin = isLogon
        UserDefaults().set(isLogin, forKey: "isLogin")
    }
    
    func getisLogin()-> String{
        let isLoginStatus : String
        isLoginStatus = UserDefaults.standard.object(forKey: "isLogin") as! String
        return isLoginStatus
    }
    
    func saveUserAdress(userAdress : String ){
        UserDefaults.standard.set(userAdress, forKey: "userAdress")
    }
    func getUserAdress()-> String{
        let userAdress = UserDefaults.standard.object(forKey: "userAdress")
        return userAdress as! String
        
    }
    func saveUsersLocationCoordinates(coordinates : lats){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(coordinates) {
            UserDefaults.standard.set(encoded, forKey: "userCoordinates")
        }
    }
    func getuserCoordinates() -> lats{
        let tempData = lats(latitude: "0.0", longitude: "0.0")
        if let coordinates = UserDefaults.standard.object(forKey: "userCoordinates") as? Data  {
            let decoder = JSONDecoder()
            let loadedInfo = try? decoder.decode(lats.self, from: coordinates)
            return loadedInfo!
        }
        else{
            return tempData
        }
    }
}
