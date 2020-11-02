//
//  Player.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 10/30/20.
//

import Foundation

struct Player: Codable, Hashable {
    var name: String
    var playerCode: String
    var uid: String
    var currentGuild: String
}
