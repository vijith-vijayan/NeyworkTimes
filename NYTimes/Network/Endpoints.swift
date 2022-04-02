//
//  Endpoints.swift
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

struct Endpoints {
    
    //MARK: - PROPRTIES
    let version: String
    let scheme: String
    let host: String
    let path: String
    let queryItems: [URLQueryItem]
    
    /* API KEY */
    static let apiKey = "5763846de30d489aa867f0711e2b031c"
}

extension Endpoints {
    
    //MARK: - GENERATE URL PATH
    static func genreateURLPath(_ page: Int) -> URL? {
        let endpoint = Endpoints(
            version: "v2",
            scheme: baseUrl?.scheme ?? "",
            host: baseUrl?.host ?? "",
            path: "/svc/search/v2/articlesearch.json",
            queryItems: [
                URLQueryItem(name: "q", value: "india"),
                URLQueryItem(name: "api-key", value: apiKey),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        )
        return endpoint.url
    }
    
    //MARK: - BASE URL
    static var baseUrl: URL? {
        return URL(string: "https://api.nytimes.com")
    }
    
    //MARK: - IMAGE BASE URL
    static var imageBaseUrl: URL? {
        return URL(string: "https://static01.nyt.com/")
    }
    
    //MARK: - URL
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
