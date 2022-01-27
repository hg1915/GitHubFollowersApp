//
//  Follower.swift
//  GitHubFollowers
//
//  Created by GGTECH LLC on 11/17/21.
//

import Foundation


struct Follower: Codable, Hashable  {
    var login: String
    var avatar_url: String
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
    
}
