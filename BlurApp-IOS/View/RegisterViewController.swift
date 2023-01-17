//
//  RegisterViewController.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 27.12.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userEmail : String = ""
    var userPassword : String = ""
    var userName : String = ""
    var userSurname : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func btnKaydolClicked(_ sender: Any) {
        
        if(emailTextField.text!.isEmpty || nameTextField.text!.isEmpty || surnameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
        ){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen boş alanları doldurunuz.", preferredStyle:UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            userName = nameTextField.text!
            userEmail = emailTextField.text!
            userSurname = surnameTextField.text!
            userPassword = passwordTextField.text!
            performSegue(withIdentifier: "sendRegisterDataSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendRegisterDataSegue"{
            let userData = segue.destination as! RouteRegisterToMainViewController
            userData.userEmail = userEmail
            userData.userPassword = userPassword
            userData.userName = userName
            userData.userSurname = userSurname
            
        }
    }
}
