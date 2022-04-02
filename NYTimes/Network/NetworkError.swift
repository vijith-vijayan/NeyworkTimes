//
//  NetworkError.swift
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

enum NetworkError: Error, Equatable {

    case invalidURL(url: String)
    case apiError(status: Int)
    case urlResponseIsNotHTTP
}
