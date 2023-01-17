//
//  UserViewModel.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 17.01.2023.
//

import Foundation

class userVM{
    func userLogout(){
        userDefaultsOptions().userLogout()
    }
}
