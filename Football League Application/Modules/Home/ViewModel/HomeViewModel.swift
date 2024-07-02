//
//  HomeViewModel.swift
//  Football League Application
//
//  Created by mariam adly on 01/07/2024.
//

import Foundation
class HomeViewModel {
   
    
    var errorMessage: String?
    var bindCompetitionToHomeVC :  (()->()) = {}
    
    var competition  : [Competition]? {
        didSet {
            bindCompetitionToHomeVC()
        }
    }
    
 func fetchData() {
       
        NetworkServices.fetchData() {
            [weak self](result: Result<CompetitionResult, Error>) in
              DispatchQueue.main.async {
                    switch result {
                    case .success(let competition):
                        self?.competition = competition.competitions
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
