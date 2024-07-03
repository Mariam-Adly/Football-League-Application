//
//  HomeTableViewCell.swift
//  Football League Application
//
//  Created by mariam adly on 01/07/2024.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var games: UILabel!
    @IBOutlet weak var numberOfTeams: UILabel!
    
    @IBOutlet weak var leagueLongName: UILabel!
    
    @IBOutlet weak var leagueShortName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
