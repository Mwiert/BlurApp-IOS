//
//  RouteToMainViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 16.01.2023.
//

import UIKit

class RouteToMainViewController: UIViewController {

    var userEmailVerify : String = ""
    var userPasswordVerify : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            let info = try await userLoginVM().userLoginReq(Email: userEmailVerify, Password: userPasswordVerify)
            
            if(info == false){
                let alert = UIAlertController(title: "Hata!", message: "Hatalı eposta veya şifre girdiniz. Lütfen tekrar deneyiniz.", preferredStyle:UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true) {
                    self.presentingViewController?.dismiss(animated: true)
                }

            }
            else {
                let userDetails = userDefaultsOptions().getUserInfo()
                if(userDetails.userType! == 0){
                    self.performSegue(withIdentifier: "login2AdminScreenSegue", sender: (Any).self)
                }
                else if(userDetails.userType! == 1){
                    self.performSegue(withIdentifier: "login2MainScreenSegue", sender: (Any).self)
                }
                else{
                    // route to emplooye screen
                }
            }
            WorkplaceVM().getAllProfessions()
        }
        
    }

}
