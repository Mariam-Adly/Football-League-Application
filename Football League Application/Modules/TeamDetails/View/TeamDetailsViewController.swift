//
//  TeamDetailsViewController.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import UIKit
import SDWebImage

class TeamDetailsViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {

    @IBOutlet weak var playersTV: UITableView!
    @IBOutlet weak var teamCode: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    var teamDetailsVM : TeamDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playersTV.delegate = self
        playersTV.dataSource = self
        
        playersTV.register(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        
        teamName.text = teamDetailsVM?.team?.name
        teamImg.sd_setImage(with: URL(string: teamDetailsVM?.team?.crest ?? ""),placeholderImage: UIImage(named: "football"))
        teamCode.text = teamDetailsVM?.team?.shortName
        
        playersTV.reloadData()
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teamDetailsVM?.team?.squad?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playersTV?.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        let data = teamDetailsVM?.team?.squad?[indexPath.row]
        cell.playerName.text = data?.name
        cell.playerPosition.text = data?.position
        cell.playerNationality.text = data?.nationality
        return cell
    }
    
    

}
