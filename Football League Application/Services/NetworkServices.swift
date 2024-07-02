//
//  NetworkServices.swift
//  Sport Application
//
//  Created by mariam adly on 20/05/2023.
//

import Foundation
import Alamofire

class NetworkServices : NetworkServiceProtocol{
    
    static func fetchData<T:Decodable>(completion: @escaping (Result<T, Error>) -> Void) {

        guard let url = URL(string: "https://api.football-data.org/v4/competitions") else { return }
        AF.request(url,method: .get).validate().response { resp in
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
