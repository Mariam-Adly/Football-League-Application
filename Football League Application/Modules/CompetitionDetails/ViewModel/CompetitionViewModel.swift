//
//  CompetitionViewModel.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation
import RxSwift
import RxRelay

class CompetitionViewModel {
    private let disposeBag = DisposeBag()

    // Inputs
    var competition: Competition?

    // Outputs
    var competitionDetails = BehaviorRelay<CompetitionDetails?>(value: nil)
    var teams = BehaviorRelay<Teams?>(value: nil)
    var errorMessage = PublishSubject<String>()
    
    init(competition: Competition? = nil) {
        self.competition = competition
    }
    
    var players: Observable<[Team]>? {
        return teams
            .compactMap { $0?.teams }
                .asObservable()
        }
    
    func fetchData() {
        NetworkServices.fetchData(endPoint: Constants.Endpoints.competitionsDetails(competitionID: competition?.id ?? 0)) { [weak self] (result: Result<CompetitionDetails, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let competitionDetails):
                    self?.competitionDetails.accept(competitionDetails)
                    DataManager.shared.saveObjects(objects: competitionDetails, forKey: "competitionDetailsKey")
                        .subscribe(
                                        onSuccess: {
                                            print("Team saved successfully.")
                                        },
                                        onFailure: { error in
                                            print("Error saving team: \(error.localizedDescription)")
                                        }
                                    )
                        .disposed(by: self?.disposeBag ?? DisposeBag())
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchTeams() {
        NetworkServices.fetchData(endPoint: Constants.Endpoints.teams(competitionID: competition?.id ?? 0)) { [weak self] (result: Result<Teams, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let teams):
                    self?.teams.accept(teams)
                    DataManager.shared.saveObjects(objects: teams, forKey: "teamsKey").subscribe(
                        onSuccess: {
                            print("Team saved successfully.")
                        },
                        onFailure: { error in
                            print("Error saving team: \(error.localizedDescription)")
                        }
                    )
        .disposed(by: self?.disposeBag ?? DisposeBag())
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }
        }
    }
}

