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
                self.performSegue(withIdentifier: "login2MainScreenSegue", sender: (Any).self)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
