//
//  NetworkServices.swift
//  Sport Application
//
//  Created by mariam adly on 20/05/2023.
//

import Foundation
import Alamofire

class NetworkServices : NetworkServiceProtocol{
    
    static func fetchData<T:Decodable>(endPoint : String,completion: @escaping (Result<T, Error>) -> Void) {
        let url = Constants.baseURL + endPoint
        let headers : HTTPHeaders = [
                "X-Auth-Token": "e5d5182727594c74bf02264addee334a"
        ]
        AF.request(url,method: .get,headers: headers).validate().response { resp in
                switch resp.result{
                case .success(let data):
                    do{
                        if let data = data{
                            let jsonData =  try JSONDecoder().decode(T.self, from: data)
                            completion(.success(jsonData))
                        }
                    }catch{
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(.failure(error))
              }
    }
    }
    
}
