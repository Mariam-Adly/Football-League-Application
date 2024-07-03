//
//  TeamTableViewCell.swift
//  Football League Application
//
//  Created by mariam adly on 02/07/2024.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamShortName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
