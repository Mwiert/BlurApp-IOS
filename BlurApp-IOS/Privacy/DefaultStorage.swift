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
    
    func saveRegisterUserInfo(userInfoLogin : mainUser){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userInfoLogin) {
            UserDefaults.standard.set(encoded, forKey: "userInfo")
        }
    }
    
    func getUserInfo() -> userProps{
        let user = userProps.init(id: .init(timestamp: 1, machine: 1, pid: 1, increment: 1, creationTime: ""), email: "not found", password: "", name: "", surname: "", token: "", tokenExpiresIn: "")
        
        if let userInfo = UserDefaults.standard.object(forKey: "userInfo") as? Data  {
            let decoder = JSONDecoder()
            var loadedInfo = try? decoder.decode(userProps.self, from: userInfo)
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
    
}
