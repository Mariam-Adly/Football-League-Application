//
//  CompetitionViewModel.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation
class CompetitionViewModel{
    var competition : Competition?
    init(competition: Competition? = nil) {
        self.competition = competition
    }
    
    var errorMessage: String?
    var bindCompetitionDetailsToCompetitionVC :  (()->()) = {}
    
    var competitionDetails  : CompetitionDetails? {
        didSet {
            bindCompetitionDetailsToCompetitionVC()
        }
    }
    
    var bindTeamsToCompetitionVC :  (()->()) = {}
    
    var teams  : Teams? {
        didSet {
            bindTeamsToCompetitionVC()
        }
    }
    
    func fetchData() {
        NetworkServices.fetchData(endPoint : Constants.Endpoints.competitionsDetails(competitionID: competition?.id ?? 0)) {
            [weak self](result: Result<CompetitionDetails, Error>) in
              DispatchQueue.main.async {
                    switch result {
                    case .success(let competitionDetails):
                        self?.competitionDetails = competitionDetails
                        DataManager.shared.saveObjects(objects: competitionDetails, forKey: "competitionDetailsKey")
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchTeams(){
        NetworkServices.fetchData(endPoint : Constants.Endpoints.teams(competitionID: competition?.id ?? 0)) {
            [weak self](result: Result<Teams, Error>) in
              DispatchQueue.main.async {
                    switch result {
                    case .success(let teams):
                        self?.teams = teams
                        DataManager.shared.saveObjects(objects: teams, forKey: "teamsKey")
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
