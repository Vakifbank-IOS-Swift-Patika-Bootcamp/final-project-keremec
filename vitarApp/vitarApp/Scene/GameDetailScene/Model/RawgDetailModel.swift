//
//  RawgDetailModel.swift
//  vitarApp
//
//  Created by Kerem Safa Dirican on 12.12.2022.
//

import Foundation

struct RawgDetailModel: Decodable {
    let id: Int?
    let tba: Bool?
    let name: String?
    let released: String?
    let description: String?
    let metacritic: Int?
    let rating: EsrbRating?
    let parentPlatforms: [ParentPlatform]?
    let developers: [Developer]?
    let publishers: [Publisher]?
    let genres: [Genre]?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case tba
        case name
        case released
        case description = "description_raw"
        case metacritic
        case developers
        case publishers
        case genres
        case rating = "esrb_rating"
        case parentPlatforms = "parent_platforms"
        case imageWide = "background_image"
    }
}

struct EsrbRating: Decodable{
    let id: Int?
    let name: String?
    let slug: String?
}


struct ParentPlatform: Decodable{
    let platform: Platform?
}

struct Platform: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
}

struct Developer: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gameCount: Int?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gameCount = "games_count"
        case imageWide = "background_image"
    }
}

struct Publisher: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gameCount: Int?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gameCount = "games_count"
        case imageWide = "background_image"
    }
}

struct Genre: Decodable {
    let id: Int?
    let name: String?
    let slug: String?
    let gameCount: Int?
    let imageWide: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gameCount = "games_count"
        case imageWide = "background_image"
    }
}
