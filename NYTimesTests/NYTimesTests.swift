//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Vijith TV on 28/03/22.
//

import XCTest
@testable import NYTimes
@testable import SDWebImage

class NYTimesTests: XCTestCase {
    
    
    func testBaseURL() {
        XCTAssertEqual(Endpoints.baseUrl?.absoluteString, "https://api.nytimes.com")
    }

    func testImageBaseURL() {
        XCTAssertEqual(Endpoints.imageBaseUrl?.absoluteString, "https://static01.nyt.com/")
    }
    
    func testAPIKey() {
        XCTAssertEqual(Endpoints.apiKey, "5763846de30d489aa867f0711e2b031c")
    }
    
    func testURLGeneration() {
        let requestURL = Endpoints.genreateURLPath(0)?.absoluteString
        XCTAssertEqual(requestURL, "https://api.nytimes.com/svc/search/v2/articlesearch.json?q=india&api-key=5763846de30d489aa867f0711e2b031c&page=0")
    }
    
    func testAPIReponse() {
        let networkLayer = GetArticlesNetworkLayer(networkClient: NetworkClient())
        Task {
            let articles = try await networkLayer.getArticles(0)
            XCTAssertNotNil(articles)
        }
    }
    
    func testDateFormat() {
        let date = "2022-03-28T11:06:55+0000"
        let formattedDate = date.dateFromString
        let publishedDate = date.publishedDate()
        let articleDate = formattedDate?.articleDate
        XCTAssertNotNil(formattedDate)
        XCTAssertNotNil(publishedDate)
        XCTAssertNotNil(articleDate)
    }
    
    func testImageDownloader() {
        let url = "\(Endpoints.imageBaseUrl?.absoluteString ?? "")images/2022/03/28/world/28india-strike-01/merlin_204640113_98df4f83-b5ce-4508-a7ab-f22935884caf-articleLarge.jpg"
        let imageURL = URL(string: url)!
        SDWebImageManager.shared.loadImage(with: imageURL, options: [], progress: nil) { image, data, error, cacheType, success, url in
            XCTAssert(image != nil, "IMAGE DOWNLOADED")
        }
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.https://api.nytimes.com/svc/search/v2/articlesearch.json?api-key=5763846de30d489aa867f0711e2b031c&q=india&page=0
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
