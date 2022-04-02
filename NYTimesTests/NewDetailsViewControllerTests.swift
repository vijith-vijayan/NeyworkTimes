//
//  NewDetailsViewControllerTests.swift
//  NYTimesTests
//
//  Created by Vijith TV on 31/03/22.
//

import XCTest
@testable import NYTimes

class NewDetailsViewControllerTests: XCTestCase {
    
    var newsDetailsVCTest: NewsDetailsViewController!
    var doc: Docs?
    var url: String?

    override func setUp() {
        //
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        newsDetailsVCTest = storyboard.instantiateViewController(withIdentifier: "newDetailsViewController") as? NewsDetailsViewController
        
        // in view controller, menuItems = ["one", "two", "three"]
        newsDetailsVCTest.loadView()
        
    }
    
    func testVCLoadIntoMemory() {
        
        newsDetailsVCTest.viewDidLoad()
        newsDetailsVCTest.setupViewmodel()
        newsDetailsVCTest.pressBack(UIButton())
    }
    
    func testArticelDetailsViewModel() {
        let networkLayer = GetArticlesNetworkLayer(networkClient: NetworkClient())
        Task {
            let articles = try await networkLayer.getArticles(0)
            XCTAssertNotNil(articles)
            doc = articles.response?.docs?.first
            
            url = doc?.getImageURL(type: .xLarge)
            XCTAssertNotNil(url)
            
            let authorName = doc?.authorFullName
            XCTAssertNotNil(authorName)
        }
        
        let articleViewModel = ArticleDetailsViewModel(with: doc)
        XCTAssertNotNil(articleViewModel)
    }
    
    
    func testHasUIElements() {
        XCTAssertNotNil(newsDetailsVCTest.articleHeadlineLabel)
        XCTAssertNotNil(newsDetailsVCTest.articleSubheadlineLabel)
        XCTAssertNotNil(newsDetailsVCTest.articlePubDateLabel)
        XCTAssertNotNil(newsDetailsVCTest.articleLeadParagraphLabel)
        XCTAssertNotNil(newsDetailsVCTest.headerImageView)
        XCTAssertNotNil(newsDetailsVCTest.articleSourceLabel)
        XCTAssertNotNil(newsDetailsVCTest.articleAuthorLabel)
    }
    
    func testImageViewHasImage() {
        newsDetailsVCTest.headerImageView.setImage(from: url ?? "")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
