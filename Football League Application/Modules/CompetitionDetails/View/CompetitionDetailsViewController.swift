//
//  CompetitionDetailsViewController.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation
import UIKit
import SDWebImage
import RxSwift

class CompetitionDetailsViewController : UIViewController{
    
    @IBOutlet weak var competitionImg: UIImageView!
    
    @IBOutlet weak var teamTV: UITableView!
    @IBOutlet weak var competitionCode: UILabel!
    @IBOutlet weak var competitionName: UILabel!
    var competitionVM : CompetitionViewModel?
    private let disposeBag = DisposeBag()
    var competitionDetails : CompetitionDetails?
    var teams : [Team]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        teamTV.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "teamCell")
        if CheckNetwork.isConnectedToInternet(){
            competitionVM?.fetchData()
            competitionVM?.fetchTeams()
            setupBindings()
        }else{
            DispatchQueue.main.async {
                DataManager.shared.getObjects(forKey: "competitionDetailsKey")
                            .observe(on: MainScheduler.instance) // Ensure the subscription is on the main thread
                            .subscribe(
                                onSuccess: { [weak self] (localObjects: CompetitionDetails?) in
                                    guard let self = self else { return }
                                    if let competitions = localObjects {
                                        self.competitionDetails = competitions
                                    } else {
                                        print("No competition found in UserDefaults.")
                                    }
                                },
                                onFailure: { error in
                                    print("Error retrieving competition: \(error.localizedDescription)")
                                }
                            )
                            .disposed(by: self.disposeBag)
                
                DataManager.shared.getObjects(forKey: "teamsKey")
                            .observe(on: MainScheduler.instance) // Ensure the subscription is on the main thread
                            .subscribe(
                                onSuccess: { [weak self] (localObjects: Teams?) in
                                    guard let self = self else { return }
                                    if let competitions = localObjects {
                                        self.teams = competitions.teams
                                        self.bindDataToTable()
                                    } else {
                                        print("No competition found in UserDefaults.")
                                    }
                                },
                                onFailure: { error in
                                    print("Error retrieving competition: \(error.localizedDescription)")
                                }
                            )
                            .disposed(by: self.disposeBag)
                
        
                self.competitionImg.sd_setImage(with: URL(string: self.competitionDetails?.emblem ?? ""),placeholderImage: UIImage(named: "football"))
                self.competitionName.text = self.competitionDetails?.name
                self.competitionCode.text = self.competitionDetails?.code
            }
        }
        
        self.competitionImg.sd_setImage(with: URL(string: self.competitionDetails?.emblem ?? ""),placeholderImage: UIImage(named: "football"))
        self.competitionName.text = self.competitionDetails?.name
        self.competitionCode.text = self.competitionDetails?.code
    }
    
    
    private func setupBindings() {
            competitionVM?.competitionDetails
                .compactMap { $0 }
                .subscribe(onNext: { [weak self] details in
                    self?.competitionImg.sd_setImage(with: URL(string: details.emblem),placeholderImage: UIImage(named: "football"))
                    self?.competitionName.text = details.name
                    self?.competitionCode.text = details.code
                }).disposed(by: disposeBag)
            
            competitionVM?.players?
                .compactMap { $0 }
                .bind(to: teamTV.rx.items(cellIdentifier: "teamCell", cellType: TeamTableViewCell.self)) { index, team, cell in
                    cell.teamImg.sd_setImage(with: URL(string: team.crest ?? ""),placeholderImage: UIImage(named: "football"))
                    cell.teamName.text = team.name
                    cell.teamShortName.text = team.shortName
                }.disposed(by: disposeBag)
        
        teamTV.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.teamTV.deselectRow(at: indexPath, animated: true)
            
            guard let storyboard = self?.storyboard else {
                print("Error: Storyboard is nil")
                return
            }

            guard let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "teamDetailsVC") as? TeamDetailsViewController else {
                print("Error: Could not instantiate CompetitionDetailsViewController")
                return
            }

        guard let navigationController = self?.navigationController else {
            print("Error: Navigation controller is nil")
            return
        }
            
            let selectedTeam = self?.competitionVM?.teams.value?.teams?[indexPath.row]
            let teamDeatailsViewModel = TeamDetailsViewModel(team: selectedTeam)
            teamDetailsVC.teamDetailsVM = teamDeatailsViewModel
            navigationController.pushViewController(teamDetailsVC, animated: true)
        }).disposed(by: disposeBag)
        
            
        }
    
    private func bindDataToTable() {
            competitionVM?.competitionDetails
                .compactMap { $0 }
                .subscribe(onNext: { [weak self] details in
                    self?.competitionImg.sd_setImage(with: URL(string: details.emblem),placeholderImage: UIImage(named: "football"))
                    self?.competitionName.text = details.name
                    self?.competitionCode.text = details.code
                }).disposed(by: disposeBag)
            
          //  competitionVM?.players?
            //    .compactMap { $0 }
        Observable.just(teams ?? [] )
                .bind(to: teamTV.rx.items(cellIdentifier: "teamCell", cellType: TeamTableViewCell.self)) { index, team, cell in
                    cell.teamImg.sd_setImage(with: URL(string: team.crest ?? ""),placeholderImage: UIImage(named: "football"))
                    cell.teamName.text = team.name
                    cell.teamShortName.text = team.shortName
                }.disposed(by: disposeBag)
        
        teamTV.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.teamTV.deselectRow(at: indexPath, animated: true)
            
            guard let storyboard = self?.storyboard else {
                print("Error: Storyboard is nil")
                return
            }

            guard let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "teamDetailsVC") as? TeamDetailsViewController else {
                print("Error: Could not instantiate CompetitionDetailsViewController")
                return
            }

        guard let navigationController = self?.navigationController else {
            print("Error: Navigation controller is nil")
            return
        }
            
            let selectedTeam = self?.competitionVM?.teams.value?.teams?[indexPath.row]
            let teamDeatailsViewModel = TeamDetailsViewModel(team: selectedTeam)
            teamDetailsVC.teamDetailsVM = teamDeatailsViewModel
            navigationController.pushViewController(teamDetailsVC, animated: true)
        }).disposed(by: disposeBag)
        
            
        }

}
