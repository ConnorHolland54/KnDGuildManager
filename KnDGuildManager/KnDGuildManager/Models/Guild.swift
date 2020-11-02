//
//  Guild.swift
//  KnDGuildManager
//
//  Created by Connor Holland on 10/30/20.
//

import Foundation

struct Guild: Codable, Hashable {
    var name: String
    var founder: String
    var members: [String]
    var requests: [String]
}
