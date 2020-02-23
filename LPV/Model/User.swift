//
//  User.swift
//  GedditChallenge
//
//  Created by Chace Teera on 19/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import Foundation

struct User: Codable {
    var name: String
    var accessToken: String
    var consecutiveRoundCount: Int
    var email: String
}

