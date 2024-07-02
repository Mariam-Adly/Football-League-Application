//
//  NetworkServiceProtocol.swift
//  Sport Application
//
//  Created by mariam adly on 29/05/2023.
//

import Foundation
protocol NetworkServiceProtocol{
    
    static func fetchData<T:Decodable>( completion: @escaping (Result<T, Error>) -> Void)
    
}

