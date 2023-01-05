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
    
 //   let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
    //let url = "http://localhost:5208/api/home/createaccount/"
    //let urlLogin = "http://localhost:5208/api/home/login/"
    
    //var jsonLogin : JSON = ["email":"kayra@kayra.com","password":"123"]
    
    
    
    //var jsonfilem : JSON = ["name":"Mertsa" ,"surname":"sahin","email":"mert23@mert.com", "password": "123"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view."
    }
    @IBAction func btnloginClicked(_ sender: Any) {
        
        //CreateUser
        if(emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty){
            let alert = UIAlertController(title: "Hata!", message: "Lütfen boş alanları doldurunuz.", preferredStyle:UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
            alert.addAction(okButton)
        }
        else{
            userLoginVM().userLoginReq(Email: emailTextField.text!, Password: passwordTextField.text!)
                let alert = UIAlertController(title: "Başarılı!", message: "Giriş yapıldı.", preferredStyle:UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default){
                (UIAlertAction) in
                self.present(alert, animated: true, completion: nil)
                self.performSegue(withIdentifier: "login2MainScreenSegue", sender: (Any).self)
            }
            
            

            
        }

        
      // LoginUser
        
     /*  AF.request(urlLogin, method: .post ,parameters: jsonLogin ,encoder:JSONParameterEncoder.default,headers: headers).responseDecodable(of : userProps.self, completionHandler: { response in
            switch response.result {
            
            case .success(let data):
            print(data)
            case .failure(let error):
            print(error.localizedDescription)
            }
        })*/
        }
    }
