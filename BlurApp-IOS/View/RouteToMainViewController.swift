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
        
        userLoginVM().userLoginReq(Email: userEmailVerify, Password: userPasswordVerify) { success in
            if !success {
                let alert = UIAlertController(title: "Hata!", message: "Hatalı eposta veya şifre girdiniz. Lütfen tekrar deneyiniz.", preferredStyle:UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true) {
                    self.presentingViewController?.dismiss(animated: true)
                }
            }
            else    {
                let userDetails = userDefaultsOptions().getUserInfo()
                WorkplaceVM().getAllProfessions { success in
                    if !success {
                        let alert = UIAlertController(title: "Hata!", message: "Beklenmedik bir hata ile karşılaşıldı. Professions could not be loaded!", preferredStyle:UIAlertController.Style.alert)
                        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
                        alert.addAction(okButton)
                        self.present(alert, animated: true) {
                            self.presentingViewController?.dismiss(animated: true)
                        }
                    }
                    else{
                        WorkplaceVM().getWorkplaces2 { success in
                            if !success{
                                let alert = UIAlertController(title: "Hata!", message: "Beklenmedik bir hata ile karşılaşıldı. Workplaces could not be loaded!", preferredStyle:UIAlertController.Style.alert)
                                let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
                                alert.addAction(okButton)
                                self.present(alert, animated: true) {
                                    self.presentingViewController?.dismiss(animated: true)
                                }
                            }
                            else{
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
                        }
                    }
                }
            }
        }
    }
}
