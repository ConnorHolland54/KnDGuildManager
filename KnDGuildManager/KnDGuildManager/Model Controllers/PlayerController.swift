//
//  PlayerController.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 10/30/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class PlayerController {
    // Shared Instance
    static let shared = PlayerController()
    
    //Database
    let db = Firestore.firestore().collection(StringConstants.players)
    
    // MARK: - Variables
    var currentPlayer: Player?
    
    // MARK: -CRUD
    //Create
    func createPlayer(name: String, friendCode:String = "", email: String, pass: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                if let uid = Auth.auth().currentUser?.uid {
                    let playerDict: [String: Any] = [
                        StringConstants.name: name,
                        StringConstants.playerCode: friendCode,
                        StringConstants.currentGuild: "",
                        StringConstants.uid: uid
                    ]
                    self.db.document(uid).setData(playerDict)
                    self.signIn(email: email, pass: pass) { (success) in
                        return completion(success)
                    }
                }
            }
        }
    }
    
    
    // MARK: - Other Methods
    
    //Log in with email and password
    func signIn(email: String, pass: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                print("Signed In")
                return completion(Auth.auth().currentUser?.uid != nil)
            }
        }
    }
    
    //converts uid to player object
    func convertUIDToPlayer(uid: String, completion: @escaping (Result<Player,Error>) -> Void) {
        db.document(uid).getDocument { (document, err) in
            if let err = err {
                print(err.localizedDescription)
            } else {
                
                let result = Result {
                    try document?.data(as: Player.self)
                }
                switch result {
                case .success(let player):
                    if let player = player {
                        completion(.success(player))
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.failure(err))
                }
            }
        }
    }
    
    //Fetch current player
    func fetchCurrentPlayer() {
        convertUIDToPlayer(uid: Auth.auth().currentUser!.uid) { (result) in
            switch result {
            case .success(let player):
                print(player)
                self.currentPlayer = player
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    
    
}
