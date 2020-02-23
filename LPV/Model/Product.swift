//
//  Product.swift
//  GedditChallenge
//
//  Created by Chace Teera on 18/02/2020.
//  Copyright © 2020 chaceteera. All rights reserved.
//

import Foundation

// Structs over Class as this is a basic data object and does not require the use of inheritance.

struct Product: Decodable {
    let id: String
    let type: String
    let attributes: Attributes


}

struct ProductData: Decodable {
    let data: [Product]
}


struct Attributes: Decodable {
    let title: String
    let description: String?
    let price: Int?
    let image: String?

}


