//
//  HomeViewController.swift
//  Football League Application
//
//  Created by mariam adly on 01/07/2024.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    var competition : [Competition]?
    var homeVM : HomeViewModel?
    private let disposeBag = DisposeBag()
    @IBOutlet weak var homeTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        homeVM = HomeViewModel()
        
        homeTV.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        
        
        if CheckNetwork.isConnectedToInternet(){
            homeVM?.fetchData()
            setupBindings()
        }else{
            DataManager.shared.getObjects(forKey: "competitionKey")
                        .observe(on: MainScheduler.instance) // Ensure the subscription is on the main thread
                        .subscribe(
                            onSuccess: { [weak self] (localObjects: [Competition]?) in
                                guard let self = self else { return }
                                if let competitions = localObjects {
                                    self.competition = competitions
                                    self.bindLocalDataToTableView()
                                } else {
                                    print("No competition found in UserDefaults.")
                                }
                            },
                            onFailure: { error in
                                print("Error retrieving competition: \(error.localizedDescription)")
                            }
                        )
                        .disposed(by: disposeBag)
           
        }
        
    }
    
    private func setupBindings() {
        homeVM?.competitions
            .bind(to: homeTV.rx.items(cellIdentifier: "homeCell", cellType: HomeTableViewCell.self)) { index, competition, cell in
                cell.numberOfTeams.text = String(competition.numberOfAvailableSeasons)
                cell.games.text = competition.type.rawValue
                cell.leagueLongName.text = competition.name
                cell.leagueShortName.text = competition.code
            }.disposed(by: disposeBag)
        
        homeTV.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.homeTV.deselectRow(at: indexPath, animated: true)
            guard let storyboard = self?.storyboard else {
                print("Error: Storyboard is nil")
                return
            }
            
            guard let competitionDetailsVC = storyboard.instantiateViewController(withIdentifier: "competitionDetailsVC") as? CompetitionDetailsViewController else {
                print("Error: Could not instantiate CompetitionDetailsViewController")
                return
            }
            
            guard let navigationController = self?.navigationController else {
                print("Error: Navigation controller is nil")
                return
            }
            
            let selectedCompetition = self?.homeVM?.competitions.value[indexPath.row]
            let competitionViewModel = CompetitionViewModel(competition: selectedCompetition)
            competitionDetailsVC.competitionVM = competitionViewModel
            navigationController.pushViewController(competitionDetailsVC, animated: true)
        }).disposed(by: disposeBag)
        
        
    }
    
    private func bindLocalDataToTableView() {
            Observable.just(competition ?? [])
                .bind(to: homeTV.rx.items(cellIdentifier: "homeCell", cellType: HomeTableViewCell.self)) { index, competition, cell in
                    cell.numberOfTeams.text = String(competition.numberOfAvailableSeasons)
                    cell.games.text = competition.type.rawValue
                    cell.leagueLongName.text = competition.name
                    cell.leagueShortName.text = competition.code
                }
                .disposed(by: disposeBag)

            homeTV.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    self?.homeTV.deselectRow(at: indexPath, animated: true)
                    guard let storyboard = self?.storyboard else {
                        print("Error: Storyboard is nil")
                        return
                    }
                    guard let competitionDetailsVC = storyboard.instantiateViewController(withIdentifier: "competitionDetailsVC") as? CompetitionDetailsViewController else {
                        print("Error: Could not instantiate CompetitionDetailsViewController")
                        return
                    }
                    guard let navigationController = self?.navigationController else {
                        print("Error: Navigation controller is nil")
                        return
                    }
                    let selectedCompetition = self?.competition?[indexPath.row]
                    let competitionViewModel = CompetitionViewModel(competition: selectedCompetition)
                    competitionDetailsVC.competitionVM = competitionViewModel
                    navigationController.pushViewController(competitionDetailsVC, animated: true)
                })
                .disposed(by: disposeBag)
        }

}

