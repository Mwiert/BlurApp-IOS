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
    let serializer = DataResponseSerializer(emptyResponseCodes: Set([200, 204, 205]))
    let url = "http://localhost:5208/api/home/createaccount/"
    let urlLogin = "http://localhost:5208/api/home/login/"
    
    var jsonLogin : JSON = ["email":"kayra@kayra.com","password":"123"]
    
    
    
    var jsonfilem : JSON = ["name":"Mertsa" ,"surname":"sahin","email":"mert23@mert.com", "password": "123"]

    let headers: HTTPHeaders = [
        "accept" : "application/json",
        "Content-Type": "application/json"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view."
    }
    @IBAction func btnloginClicked(_ sender: Any) {

        //CreateUser
       AF.request(url, method: .post ,parameters: jsonfilem ,encoder: JSONParameterEncoder.default,headers: headers).responseDecodable(of : mainUser.self, completionHandler: { response in
             switch response.result {
             
             case .success(let data):
             print(data)
             case .failure(let error):
             print(error.localizedDescription)
             }
         })
        
      // LoginUser
        
       AF.request(urlLogin, method: .post ,parameters: jsonLogin ,encoder:JSONParameterEncoder.default,headers: headers).responseDecodable(of : userProps.self, completionHandler: { response in
            switch response.result {
            
            case .success(let data):
            print(data)
            case .failure(let error):
            print(error.localizedDescription)
            }
        })
             
            /*    AF.request("http://localhost:5208/api/home/login2/",method: .get, parameters: parameters,encoder: .json,headers: .default).validate(contentType: ["application/json;+charset=UTF-8"]).response { (response) in
             switch response.result{
             case .success(let data):
             print(data)
             case .failure(let error):
             print(error.localizedDescription)
             }
             }
             */
            
        }
    }
