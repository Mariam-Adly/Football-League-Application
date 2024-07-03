//
//  CompetitionDetailsViewController.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import Foundation
import UIKit
import SDWebImage

class CompetitionDetailsViewController : UIViewController ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var competitionImg: UIImageView!
    
    @IBOutlet weak var teamTV: UITableView!
    @IBOutlet weak var competitionCode: UILabel!
    @IBOutlet weak var competitionName: UILabel!
    var competitionVM : CompetitionViewModel?
    var competitionDetails : CompetitionDetails?
    var teams : [Team]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamTV.delegate = self
        teamTV.dataSource = self
        
        teamTV.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "teamCell")
        if CheckNetwork.isConnectedToInternet(){
            competitionVM?.fetchData()
            competitionVM?.bindCompetitionDetailsToCompetitionVC = {
                DispatchQueue.main.async {
                    self.competitionDetails = self.competitionVM?.competitionDetails
                    self.competitionImg.sd_setImage(with: URL(string: self.competitionDetails?.emblem ?? ""),placeholderImage: UIImage(named: "football"))
                    self.competitionName.text = self.competitionDetails?.name
                    self.competitionCode.text = self.competitionDetails?.code
                }
            }
            
            competitionVM?.fetchTeams()
            competitionVM?.bindTeamsToCompetitionVC = {
                DispatchQueue.main.async {
                    self.teams = self.competitionVM?.teams?.teams
                    self.teamTV.reloadData()
                }
            }
        }else{
            DispatchQueue.main.async {
                if let localObjects : CompetitionDetails = DataManager.shared.getObjects(forKey:"competitionDetailsKey") {
                    self.competitionDetails = localObjects
                    
                }
                if let localObjects2 : Teams = DataManager.shared.getObjects(forKey:"teamsKey") {
                    self.teams = localObjects2.teams
                    self.teamTV.reloadData()
                }
                self.competitionImg.sd_setImage(with: URL(string: self.competitionDetails?.emblem ?? ""),placeholderImage: UIImage(named: "football"))
                self.competitionName.text = self.competitionDetails?.name
                self.competitionCode.text = self.competitionDetails?.code
            }
        }
        
        self.competitionImg.sd_setImage(with: URL(string: self.competitionDetails?.emblem ?? ""),placeholderImage: UIImage(named: "football"))
        self.competitionName.text = self.competitionDetails?.name
        self.competitionCode.text = self.competitionDetails?.code
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = teamTV.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! TeamTableViewCell
        let data = teams?[indexPath.row]
        cell.teamImg.sd_setImage(with: URL(string: data?.crest ?? ""),placeholderImage: UIImage(named: "football"))
        cell.teamName.text = data?.name
        cell.teamShortName.text = data?.shortName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

            guard let storyboard = self.storyboard else {
                print("Error: Storyboard is nil")
                return
            }

            guard let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "teamDetailsVC") as? TeamDetailsViewController else {
                print("Error: Could not instantiate CompetitionDetailsViewController")
                return
            }

        guard let navigationController = self.navigationController else {
            print("Error: Navigation controller is nil")
            return
        }
          
        let controller = TeamDetailsViewModel(team: teams?[indexPath.row])
        teamDetailsVC.teamDetailsVM = controller
        navigationController.pushViewController(teamDetailsVC, animated: true)
      }
}
