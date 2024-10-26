//
//  Request.swift
//  upwards-ios-challenge
//
//  Created by Alex Livenson on 9/13/21.
//

import Foundation

enum HTTPMethod: String {
    /// `DELETE` method.
    case delete = "DELETE"
    /// `GET` method.
    case get = "GET"
    /// `POST` method.
    case post = "POST"
    /// `PUT` method.
    case put = "PUT"
}

protocol Request: CustomStringConvertible {
    func asURLRequest() throws -> URLRequest
}
