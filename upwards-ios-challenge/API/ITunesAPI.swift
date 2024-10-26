//
//  ITunesAPI.swift
//  upwards-ios-challenge
//
//  Created by Alex Livenson on 9/13/21.
//

import Foundation

let baseURL = "https://rss.applemarketingtools.com"

final class ITunesAPI {
    
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func getTopAlbums(limit: Int = 10, completion: @escaping (Result<AlbumFeed, Error>) -> ())  {
        let request = APIRequest(url: "\(baseURL)/api/v2/us/music/most-played/\(limit)/albums.json")
        network.requestObject(request, completion: completion)
    }
}
