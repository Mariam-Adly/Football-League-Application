//
//  HomeViewController.swift
//  Football League Application
//
//  Created by mariam adly on 01/07/2024.
//

import Foundation
import UIKit

class HomeViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var competition : [Competition]?
    var homeVM : HomeViewModel?
    
    @IBOutlet weak var homeTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeTV.delegate = self
        homeTV.dataSource = self
        
        homeVM = HomeViewModel()
        
        homeTV.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "homeCell")
        
        if CheckNetwork.isConnectedToInternet(){
            homeVM?.fetchData()
            homeVM?.bindCompetitionToHomeVC = {
                DispatchQueue.main.async {
                    self.competition = self.homeVM?.competition
                    self.homeTV.reloadData()
                }
            }
        }else{
            DispatchQueue.main.async {
                if let localObjects : [Competition] = DataManager.shared.getObjects(forKey:"competitionKey") {
                    self.competition = localObjects
                    self.homeTV.reloadData()
                }
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competition?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeTableViewCell
        let data = competition?[indexPath.row]
        cell.numberOfTeams.text = String(data?.numberOfAvailableSeasons ?? 0)
        cell.games.text = data?.type.rawValue
        cell.leagueLongName.text = data?.name
        cell.leagueShortName.text = data?.code
       return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

            guard let storyboard = self.storyboard else {
                print("Error: Storyboard is nil")
                return
            }

            guard let competitionDetailsVC = storyboard.instantiateViewController(withIdentifier: "competitionDetailsVC") as? CompetitionDetailsViewController else {
                print("Error: Could not instantiate CompetitionDetailsViewController")
                return
            }

        guard let navigationController = self.navigationController else {
            print("Error: Navigation controller is nil")
            return
        }
          
        let controller = CompetitionViewModel(competition: competition?[indexPath.row])
        competitionDetailsVC.competitionVM = controller
        navigationController.pushViewController(competitionDetailsVC, animated: true)
      }
}

