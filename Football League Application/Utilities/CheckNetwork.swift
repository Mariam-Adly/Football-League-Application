//
//  CheckNetwork.swift
//  Sport Application
//
//  Created by mariam adly on 25/05/2023.
//

import Foundation
import Alamofire

class CheckNetwork{
    class func isConnectedToInternet() -> Bool {
           return NetworkReachabilityManager()?.isReachable ?? false
       }
    
}


