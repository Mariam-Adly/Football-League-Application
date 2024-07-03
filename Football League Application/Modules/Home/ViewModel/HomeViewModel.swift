//
//  HomeViewModel.swift
//  Football League Application
//
//  Created by mariam adly on 01/07/2024.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class HomeViewModel {
    private let disposeBag = DisposeBag()

    var competitions = BehaviorRelay<[Competition]>(value: [])
    var errorMessage = PublishSubject<String>()
    
    func fetchData() {
        NetworkServices.fetchData(endPoint: Constants.Endpoints.competitions) { [weak self] (result: Result<CompetitionResult, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let competitionResult):
                    self?.competitions.accept(competitionResult.competitions)
                    DataManager.shared.saveObjects(objects: competitionResult.competitions, forKey: "competitionKey")
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
}
