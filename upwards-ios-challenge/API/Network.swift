//
//  Network.swift
//  upwards-ios-challenge
//
//  Created by Alex Livenson on 9/13/21.
//

import Foundation
import os.log

fileprivate let general = OSLog(subsystem: "com.upwards.challenge", category: "general")

final class Network: NSObject, Networking, URLSessionDelegate {
    
    private let sessionConfig: URLSessionConfiguration
    private let decoder = JSONDecoder()
    private lazy var session: URLSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
    
    init(sessionConfig: URLSessionConfiguration) {
        self.sessionConfig = sessionConfig
        super.init()
        configureDecoder()
    }
    
    func requestObject<T: Decodable>(_ request: Request, completion: @escaping (Result<T, Error>) -> ()) {
        requestData(request) { res in
            completion(
                res.flatMap { data in
                    Result {
                        try self.decoder.decode(T.self, from: data)
                    }
                }
            )
        }
    }
    
    func requestData(_ request: Request, completion: @escaping (Result<Data, Error>) -> ()) {
        let task = session.dataTask(with: try! addLog(request).asURLRequest()) { (data, res, err) in
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

    private func addLog(_ request: Request) -> Request {
        os_log("%s", log: general, type: .debug, request.description)
        return request
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
