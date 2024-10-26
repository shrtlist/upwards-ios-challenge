//
//  Album.swift
//  upwards-ios-challenge
//
//  Created by Alex Livenson on 9/13/21.
//

import Foundation

// MARK: - Album
struct Album: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case artworkUrl100
        case artistName
        case releaseDate
    }
    
    var id: String
    var name: String
    var artworkUrl100: String?
    var artistName: String
    var releaseDate: Date
}

// MARK: - AlbumFeed
struct AlbumFeed: Decodable {
    struct Feed: Decodable {
        var results: [Album]
    }
    
    var feed: Feed
}
