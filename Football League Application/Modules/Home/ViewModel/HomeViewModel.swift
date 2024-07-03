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
     guard let url = URL(string: "https://api.football-data.org/v4/competitions") else { return }
     NetworkServices.fetchData(endPoint: Constants.Endpoints.competitions) {
            [weak self](result: Result<CompetitionResult, Error>) in
              DispatchQueue.main.async {
                    switch result {
                    case .success(let competition):
                        self?.competition = competition.competitions
                        DataManager.shared.saveObjects(objects: competition.competitions, forKey: "competitionKey")
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
