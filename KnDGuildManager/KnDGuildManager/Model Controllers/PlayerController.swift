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
    
    //Checks if player already exists. If they dont, then create new player and if they do, just sign in.

    
    
}
