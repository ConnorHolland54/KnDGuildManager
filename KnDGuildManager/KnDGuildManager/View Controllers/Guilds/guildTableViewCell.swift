//
//  guildTableViewCell.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 11/3/20.
//

import UIKit

class guildTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var founderLabel: UILabel!
    @IBOutlet weak var joinButtonTapped: UIButton!
    
    var guild: Guild?  {
        didSet {
            updateCell()
        }
    }
    
    func updateCell() {
        joinButtonTapped.backgroundColor = .green
        if let guild = guild {
            nameLabel.text = guild.name
            
            PlayerController.shared.convertUIDToPlayer(uid: guild.founder) { (result) in
                switch result {
                case .success(let player):
                    self.founderLabel.text = "Founder: \(player.name)"
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }

}
