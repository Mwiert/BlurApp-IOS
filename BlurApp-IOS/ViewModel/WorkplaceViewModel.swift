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
    
    func nearestWPs()async throws{
        let myData = CoordinatesStruct(topLeft: lats.init(latitude: "20,23423", longitude: "100,124"), bottomRight: lats.init(latitude: "50,234234", longitude: "40,23423"))
        
        
        
       let request = AF.request(reqUrl().getnearestWorkPlacesUrl, method: .post, parameters: myData, encoder: JSONParameterEncoder.default, headers: apiService().reqHeaders).serializingDecodable([GetWorkplaces].self)
        
        switch await request.response.result{
        case .success(let data):
            print(data)
        case .failure(let error):
            print(error)
        }
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
                  print(data)
              case .failure(_):
                  print(response.error?.localizedDescription)
              }
          })
        
        
    }
    func getAllProfessionsAsync() async throws -> [professionInfo]{
        var returnFail : [professionInfo] = []
        let request = AF.request(reqUrl().getallProfessionsUrl, method: .get, headers: apiService().reqHeaders).serializingDecodable([professionInfo].self)
        
        
        switch await request.response.result {
                  case .success(let data):
                      return data
                  case .failure(let error):
                      print(error.localizedDescription)
            return returnFail
                  }
              }
    func getAllProfessions(){
        
        AF.request(reqUrl().getallProfessionsUrl, method: .get, headers: apiService().reqHeaders).responseDecodable(of: [professionInfo].self,completionHandler: { response in
                  switch response.result {
                  case .success(let data):
                //responseData kullanılırsa bu fonksiyon ile structa ata    //let getAllProfessionlist = try? JSONDecoder().decode([professionInfoString].self, from: data)
                      
                      print(data)
                  case .failure(_):
                      print(response.error?.localizedDescription)
                  }
              }
        )
    }
    
    func createSingleProfession(professionName : String){
         let professionName1 : JSON = ["nameOfProfession":"\(professionName)"]
         
        AF.request(reqUrl().createSingleProfessionUrl, method: .post ,parameters: professionName1 ,encoder: JSONParameterEncoder.default ,headers: apiService().headerWithToken()).responseDecodable(of: [professionInfo].self, completionHandler: { response in
               switch response.result {
               case .success(let data):
                   let myData = data
               case .failure(_):
                   print(response.error?.localizedDescription)
               }
           })
     }
    func getWorkplaces1(completion: @escaping ([Workplace]) -> Void) {
        AF.request(reqUrl().getallWorkplacesUrl, method: .get, headers: apiService().headerWithToken())
            .responseDecodable(of: [Workplace].self) { response in
                switch response.result {
                    case .success(let data):
                    dataStorage().saveWorkplaceList(workplaces: data)
                        completion(data)
                    case .failure(let error):
                        print(error)
                        print(response.data)
                }
            }
    }

}
