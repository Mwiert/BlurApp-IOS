//
//  ProfileViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var usersNameText: UILabel!
    
    @IBOutlet weak var usersEmailText: UILabel!
    
    @IBOutlet weak var usersPhoneNumberText: UILabel!
    
    @IBOutlet weak var usersAdressText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
getUserInfo()
        // Do any additional setup after loading the view.
    }
    
    func getUserInfo(){
        let userInfo = userDefaultsOptions().getUserInfo()
        let userAdress = userDefaultsOptions().getUserAdress()
        usersNameText.text! = "\(userInfo.name!.capitalized) \(userInfo.surname!.capitalized)"
        usersEmailText.text = userInfo.email
        usersPhoneNumberText.text = "Yakında gerekecek"
        usersAdressText.text = userAdress
    }
}
