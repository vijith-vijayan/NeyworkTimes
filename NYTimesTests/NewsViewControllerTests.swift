//
//  NewsViewControllerTests.swift
//  NYTimesTests
//
//  Created by Vijith TV on 30/03/22.
//

import XCTest
@testable import NYTimes

class NewsViewControllerTests: XCTestCase {

    var newVCTest: NewsViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.newVCTest = storyboard.instantiateViewController(withIdentifier: "newViewController") as? NewsViewController
        
        // in view controller, menuItems = ["one", "two", "three"]
        self.newVCTest.loadView()
        self.newVCTest.viewDidLoad()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testHasTableView() {
        XCTAssertNotNil(newVCTest.tableView)
    }
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(newVCTest.tableView.delegate)
    }
    
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(newVCTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(newVCTest.responds(to: #selector(newVCTest.tableView(_:didSelectRowAt:))))
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(newVCTest.tableView.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertNotNil(newVCTest.datasource)
    }
    
    func testTableViewCellHasReuseIdentifier() {
        let actualReuseIdentifer = ArticleCell.identifier
        let expectedReuseIdentifier = "ArticleCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testTableViewConformsToTableViewPrefetchDatasource() {
        XCTAssertTrue(newVCTest.conforms(to: UITableViewDataSourcePrefetching.self))
        XCTAssertTrue(newVCTest.responds(to: #selector(newVCTest.tableView(_:prefetchRowsAt:))))
    }
    
    func testTableViewFooterView() {
        XCTAssert((newVCTest.createFooterLoaderView() != nil))
    }
}

