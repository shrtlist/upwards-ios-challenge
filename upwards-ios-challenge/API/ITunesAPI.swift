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

    func getTopAlbums(limit: Int = 10) async throws -> [Album] {
        return try await withCheckedThrowingContinuation { continuation in
            let request = APIRequest(url: "\(baseURL)/api/v2/us/music/most-played/\(limit)/albums.json")
            network.requestObject(request) { (result: Result<AlbumFeed, Error>) in
                switch result {
                case .success(let data):
                    continuation.resume(returning: data.feed.results)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
