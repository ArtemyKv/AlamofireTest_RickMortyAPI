//
//  Cocktail.swift
//  AlamofireTest
//
//  Created by Artem Kvashnin on 19.02.2023.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let species: String
    let imageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case species
        case imageURL = "image"
    }
}

struct Response: Codable {
    let results: [Character]
    let pages: Int
    let nextPageURL: URL
    
    enum CodingKeys: String, CodingKey {
        case pages
        case nextPageURL = "next"
    }
    
    enum ContainerKeys: String, CodingKey {
        case results
        case info
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ContainerKeys.self)
        self.results = try container.decode([Character].self, forKey: ContainerKeys.results)
        let infoContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: ContainerKeys.info)
        self.pages = try infoContainer.decode(Int.self, forKey: CodingKeys.pages)
        self.nextPageURL = try infoContainer.decode(URL.self, forKey: CodingKeys.nextPageURL)
    }
}
