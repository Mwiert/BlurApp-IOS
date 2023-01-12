//
//  ProfessionViewModel.swift
//  BlurApp-IOS
//
//  Created by Mert Şahin on 10.01.2023.
//

import Foundation
import CoreLocation
import MapKit
import SwiftyJSON
import Alamofire

public class WorkplaceVM{
    func createWorkplaceLocation(){
        
    }
    
    func createNewWorkplace(createNewWorkplace : createWorkplace){
        
        let professionParams : JSON = ["name":"\(createNewWorkplace.name!)",
                                       "latitude":"\(createNewWorkplace.latitude!)"
                                       ,"longitude":"\(createNewWorkplace.longitude!)"
                                       ,"professionName":"\(createNewWorkplace.professionName!)"
        ]
        
        AF.request(reqUrl().createWorkplaceUrl, method: .post ,parameters: professionParams ,encoder: JSONParameterEncoder.default ,headers: apiService().headerWithToken()).responseDecodable(of: fullWorkplace.self,completionHandler: { response in
              switch response.result {
              case .success(let data):
            //responseData kullanılırsa bu fonksiyon ile structa ata    //  let myWorkplace = try? JSONDecoder().decode(fullWorkplace.self, from: data)
                  let myData = data
              case .failure(_):
                  print(response.error?.localizedDescription)
              }
          })
        
        
    }
    
    func getWorkplacesByCategory(){
    
        AF.request(reqUrl().getallWorkplaces, method: .get, headers: apiService().headerWithToken()).responseDecodable(of: [GetWorkplaces].self ,completionHandler: { response in
                  switch response.result {
                  case .success(let data):
                //responseData kullanılırsa bu fonksiyon ile structa ata    //let myWorkplaces = try? JSONDecoder().decode(fullWorkplace.self, from: data)
                      
                      print(data)
                  case .failure(_):
                      print(response.error?.localizedDescription)
                  }
              }
        )
        
        
    }
}
