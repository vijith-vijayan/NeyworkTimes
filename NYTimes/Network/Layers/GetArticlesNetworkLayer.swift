//
//  GetHotEntitiesNetworkLayer.swift
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import Foundation

//MARK: - GET ARTICLES NETWORK LAYER INTERFACE

protocol GetArticlesNetworkLayerInterface {
    func getArticles(_ page: Int) async throws -> Articles
}

//MARK: - GET ARTICLE NETWORK LAYER

final class GetArticlesNetworkLayer: GetArticlesNetworkLayerInterface {
    
    //MARK: - PROPERTIES

    /* NETWORK CLIENT */
    private let networkClient: NetworkClientInterface

    //MARK: - INITIALIZER

    init(networkClient: NetworkClientInterface) {
        self.networkClient = networkClient
    }

    //MARK: - GET ARTICLES

    func getArticles(_ page: Int = 0) async throws -> Articles {
        let URL = Endpoints.genreateURLPath(page)
        guard let url = URL else {
            throw NetworkError.invalidURL(url: URL?.absoluteString ?? "")
        }

        let (data, _) = try await networkClient.dataTask(url: url, method: .get)
        let decoder = JSONDecoder()
        return try decoder.decode(Articles.self, from: data)
    }
}
