//
//  PlayerTableViewCell.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNationality: UILabel!
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
