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
    
    
    var userEmail : String = ""
    var userPassword : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WorkplaceVM().getWorkplaces1 { locationWps in
        }
        
        // Do any additional setup after loading the view."
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        if(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty){
            let alert = UIAlertController(title: "Hata!", message: "Hatalı eposta veya şifre girdiniz. Lütfen tekrar deneyiniz.", preferredStyle:UIAlertController.Style.alert)
            self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            userEmail = emailTextField.text!
            userPassword = passwordTextField.text!
           performSegue(withIdentifier: "sendLoginDataSegue", sender: nil )
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendLoginDataSegue"
        {
            let userLoginData = segue.destination as! RouteToMainViewController
            userLoginData.userEmailVerify = userEmail
            userLoginData.userPasswordVerify = userPassword
        }
    }
}

  

