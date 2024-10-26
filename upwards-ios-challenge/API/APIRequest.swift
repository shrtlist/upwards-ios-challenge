//
//  APIRequest.swift
//  upwards-ios-challenge
//
//  Created by Alex Livenson on 9/13/21.
//

import Foundation

struct APIRequest: Request {

    var url: String
    var method: HTTPMethod = .get
    var headers: [String: String]? = nil
    var params: [URLQueryItem]?
    var body: Data? = nil

    func asURLRequest() throws -> URLRequest {
        guard let apiURL = URL(string: url) else {
            throw APIErrors.custom("Invalid URL \(url)")
        }
        
        var urlComponents = URLComponents(url: apiURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = params
        
        guard let requestURL = urlComponents?.url else {
            throw APIErrors.custom("Invalid url")
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body

        return request
    }
    
    var description: String {
        "\(method) - \(url)"
    }
}
