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
    
    func searchSelectedWorkplacesByProfesionName(professionName : String, WorkplaceData : [Workplace]) -> [Workplace]{
        
        var tempData: [Workplace] = []
        
        for myData in WorkplaceData{
            if(myData.professionName == professionName){
                tempData.append(myData)
            }
        }
        return tempData
    }
    
    func searchSelectedWorkplacesByProfesionNameAndName(professionName : String , profName : String, WorkplaceData : [Workplace]) -> [Workplace]{
        
        var tempData: [Workplace] = []
        
        for myData in WorkplaceData{
            if(myData.professionName == professionName && myData.name == profName){
                tempData.append(myData)
            }
        }
        return tempData
    }
    
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
            dataStorage().saveProfessions(professions: data)
                      return data

                  case .failure(let error):
                      print(error.localizedDescription)
            return returnFail
                  }
              }
    func getAllProfessions(completion: @escaping (Bool) -> Void){
       AF.request(reqUrl().getallProfessionsUrl, method: .get, headers: apiService().headerWithToken()).responseDecodable(of: [professionInfo].self,completionHandler: { response in
            
            if let statuscode = response.response?.statusCode{
                print(statuscode)
            }

                  switch response.result {
                  case .success(let data):
                      dataStorage().saveProfessions(professions: data)
                      completion(true)
                  case .failure(_):
                      print(response.error?.localizedDescription)
                      completion(false)
                  }
              })
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
            .responseDecodable(of: [Workplace2].self) { response in
                switch response.result {
                    case .success(let data):
                    
                    var workplaceArray: [Workplace] = []

                    for workplace in data {
                         let latitudeNew = String(workplace.location.latitude!)
                           let longitudeNew = String(workplace.location.longitude!)
                            let workplace = Workplace(id: workplace.id, professionName: workplace.professionName, name: workplace.name, location: Location(latitude: latitudeNew, longitude: longitudeNew))
                            workplaceArray.append(workplace)
                        
                    }
                    dataStorage().saveWorkplaceList(workplaces: workplaceArray)
                        completion(workplaceArray)
                    case .failure(let error):
                        print(error)
                        print(response.data)
                }
            }
    }
    
    func getWorkplaces2(completion: @escaping (Bool) -> Void) {  // BOOL DÖNDÜREN
        AF.request(reqUrl().getallWorkplacesUrl, method: .get, headers: apiService().headerWithToken())
            .responseDecodable(of: [Workplace2].self) { response in
                if let statuscode = response.response?.statusCode{
                    print(statuscode)
                }
                
                switch response.result {
                    case .success(let data):
                    
                    var workplaceArray: [Workplace] = []

                    for workplace in data {
                         let latitudeNew = String(workplace.location.latitude!)
                           let longitudeNew = String(workplace.location.longitude!)
                            let workplace = Workplace(id: workplace.id, professionName: workplace.professionName, name: workplace.name, location: Location(latitude: latitudeNew, longitude: longitudeNew))
                            workplaceArray.append(workplace)
                        
                    }
                    dataStorage().saveWorkplaceList(workplaces: workplaceArray)
                        completion(true)
                    case .failure(let error):
                        print(error)
                        print(response.data)
                    completion(false)
                }
            }
    }
}
