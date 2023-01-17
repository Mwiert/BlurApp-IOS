//
//  RouteRegisterToMainViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 16.01.2023.
//

import UIKit

class RouteRegisterToMainViewController: UIViewController {

    var userEmail : String = ""
    var userPassword : String = ""
    var userName : String = ""
    var userSurname : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task{
            let info = try await userRegisterVM().userRegisterReq(Email: userEmail, Password: userPassword, Name: userName, Surname: userSurname)
            
            if(info == false){
                let alert = UIAlertController(title: "Hata!", message: "Beklenmedik bir sorunla karşılaşıldı. Lütfen tekrar deneyiniz.", preferredStyle:UIAlertController.Style.alert)
                self.present(alert, animated: true) {
                    self.presentingViewController?.dismiss(animated: true)
                }
                let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
            }
            else {
                self.performSegue(withIdentifier: "verificationSegue", sender: (Any).self)
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
