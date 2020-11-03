//
//  GuildController.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 11/3/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class GuildController {
    
    static let shared = GuildController()
    let db = Firestore.firestore().collection(StringConstants.guilds)
    var guilds: [Guild] = []
    
    // MARK: - CRUD Methods
    func createGuild(name: String) {
        
        let guildDict: [String: Any] = [
            StringConstants.name: name,
            StringConstants.founder: PlayerController.shared.currentPlayer!.uid,
            StringConstants.members: [],
            StringConstants.requests: []
        ]
        db.document(name).setData(guildDict)
    }
    
    //Read
    //Fetch all guilds
    func fetchGuilds() {
        
    }
    
    
}
