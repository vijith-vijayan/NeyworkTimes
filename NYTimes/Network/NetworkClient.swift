//
//  NetworkClient.swift
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

//MARK: - NETWORK CLIENT INTERFACE
protocol NetworkClientInterface {
    func dataTask(url: URL, method: HTTPMethod) async throws -> (Data, HTTPURLResponse)
}

//MARK: - NETWORK CLIENT

final class NetworkClient: NetworkClientInterface {

    //MARK: - PROPERTIES

    /* SESSION */
    private let session: URLSession

    //MARK: - INITIALIZER

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    //MARK: - DATA TASK WITH HTTP METHOD

    func dataTask(url: URL, method: HTTPMethod) async throws -> (Data, HTTPURLResponse) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        let (data, urlResponse) = try await session.data(for: request)

        guard let httpURLResponse = urlResponse as? HTTPURLResponse else {
            throw NetworkError.urlResponseIsNotHTTP
        }
        guard 200 ... 299 ~= httpURLResponse.statusCode else {
            throw NetworkError.apiError(status: httpURLResponse.statusCode)
        }
        return (data, httpURLResponse)
    }
}
