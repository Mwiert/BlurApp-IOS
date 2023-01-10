//
//  LoginViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view."
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        let userInfo = userDefaultsOptions().getUserInfo()
        
        if(userInfo.email! == "not found"){
            let alert = UIAlertController(title: "Hata!", message: "Hatalı eposta veya şifre girdiniz. Lütfen tekrar deneyiniz.", preferredStyle:UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            self.performSegue(withIdentifier: "login2MainScreenSegue", sender: (Any).self)
        }
    }
    
    @IBAction func btnCheckClicked(_ sender: Any) {
       if(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen boş alanları doldurunuz.", preferredStyle:UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            userLoginVM().userLoginReq(Email: emailTextField.text!, Password: passwordTextField.text!)
            btnCheck.setTitle("Devam ediniz", for:  .normal)
            btnLogin.isHidden = false
            
        }
    }
}

  

