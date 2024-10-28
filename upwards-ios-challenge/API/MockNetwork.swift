//
//  MockNetwork.swift
//  upwards-ios-challenge
//
//  Created by Marco Abundo on 10/27/24.
//

import Foundation

final class MockNetwork: NSObject, Networking, URLSessionDelegate {

    private let sessionConfig: URLSessionConfiguration
    private let decoder = JSONDecoder()
    private lazy var session: URLSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
    private let jsonString = """
{"feed":{"title":"Top Albums","id":"https://rss.applemarketingtools.com/api/v2/us/music/most-played/2/albums.json","author":{"name":"Apple","url":"https://www.apple.com/"},"links":[{"self":"https://rss.applemarketingtools.com/api/v2/us/music/most-played/2/albums.json"}],"copyright":"Copyright © 2024 Apple Inc. All rights reserved.","country":"us","icon":"https://www.apple.com/favicon.ico","updated":"Mon, 28 Oct 2024 04:29:58 +0000","results":[{"artistName":"Rod Wave","id":"1772368554","name":"Last Lap","releaseDate":"2024-10-11","kind":"albums","artistId":"1140623439","artistUrl":"https://music.apple.com/us/artist/rod-wave/1140623439","contentAdvisoryRating":"Explict","artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music221/v4/5a/37/da/5a37da14-dea1-6123-6553-4a24010657e8/196872534610.jpg/100x100bb.jpg","genres":[{"genreId":"34","name":"Music","url":"https://itunes.apple.com/us/genre/id34"},{"genreId":"18","name":"Hip-Hop/Rap","url":"https://itunes.apple.com/us/genre/id18"}],"url":"https://music.apple.com/us/album/last-lap/1772368554"},{"artistName":"BigXthaPlug","id":"1771890358","name":"TAKE CARE","releaseDate":"2024-10-11","kind":"albums","artistId":"1482508209","artistUrl":"https://music.apple.com/us/artist/bigxthaplug/1482508209","contentAdvisoryRating":"Explict","artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Music211/v4/0e/87/3e/0e873e63-acef-c677-b27f-620afd4b74d8/198748813195.png/100x100bb.jpg","genres":[{"genreId":"18","name":"Hip-Hop/Rap","url":"https://itunes.apple.com/us/genre/id18"},{"genreId":"34","name":"Music","url":"https://itunes.apple.com/us/genre/id34"}],"url":"https://music.apple.com/us/album/take-care/1771890358"}]}}
"""

    init(sessionConfig: URLSessionConfiguration) {
        self.sessionConfig = sessionConfig
        super.init()
        configureDecoder()
    }

    func requestObject<T: Decodable>(_ request: Request, completion: @escaping (Result<T, Error>) -> ()) {
        completion(
            Result {
                try self.decoder.decode(T.self, from: Data(jsonString.utf8))
            }
        )
    }

    func requestData(_ request: Request, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = session.dataTask(with: try! request.asURLRequest()) { (data, res, err) in
            guard
                let httpResponse = res as? HTTPURLResponse,
                let d = data,
                (200..<300) ~= httpResponse.statusCode
            else {
                completion(.failure(APIErrors.custom("Failed to api response")))
                return
            }

            completion(.success(d))
        }
        task.resume()
    }

    private func configureDecoder() {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)

        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateStr) {
                return date
            }

            throw APIErrors.custom("Invalid date")
        })
    }
}
