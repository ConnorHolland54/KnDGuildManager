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
    var myGuilds: [Guild] = []
    
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
    func fetchGuildsForSpecificPlayer(completion: @escaping (Bool) -> Void) {
        myGuilds = []
        db.whereField(StringConstants.founder, isEqualTo: PlayerController.shared.currentPlayer?.uid).getDocuments { (querySnapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                for document in querySnapshot!.documents {
                    
                    let result = Result {
                        try document.data(as: Guild.self)
                    }
                    
                    switch result {
                    case .success(let guild):
                        if let guild = guild {
                            self.myGuilds.append(guild)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }    
                }
            }
            completion(!self.myGuilds.isEmpty)
        }
    }
    
    //Fetch all guilds
    func fetchGuilds(completion: @escaping (Bool) -> Void) {
        guilds = []
        db.getDocuments { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    let result = Result {
                        try document.data(as: Guild.self)
                    }
                    switch result {
                    case .success(let guild):
                        if let guild = guild {
                            self.guilds.append(guild)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }  
            }
            completion(!self.guilds.isEmpty)
        }
    }
    
    //Adds players to the requests for a specific guild
    func request(guildName: String) {
        
        db.document(guildName).getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                let data = document?.data()
                var array = data![StringConstants.requests] as? Array<Any>
                array?.append(PlayerController.shared.currentPlayer!.uid)
                self.db.document(guildName).updateData([StringConstants.requests: array!])
            }
        }
    }
    
    //Cancel Request to join
    func cancelRequest(guildName: String) {
        db.document(guildName).getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                let data = document?.data()
                guard var array = data![StringConstants.requests] as? Array<Any> else {return}
                
                var count = -1
                for uid in array {
                    count += 1
                    if uid as! String == Auth.auth().currentUser!.uid {
                        array.remove(at: count)
                    }
                }

                self.db.document(guildName).updateData([StringConstants.requests: array])
            }
        }
    }
    
    func checkRequests(guildName: String, completion: @escaping (Bool) -> Void) {
        db.document(guildName).getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                let data = document!.data()
                guard let array = data![StringConstants.requests] as? Array<Any> else {return}
                for uid in array {
                    if uid as! String == PlayerController.shared.currentPlayer!.uid {
                        return completion(true)
                    }
                }
            }
        }
        
        
        return completion(false)
    }
    
}
