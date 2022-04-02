//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Vijith TV on 28/03/22.
//

import XCTest
@testable import NYTimes

class NYTimesUITests: XCTestCase {
    
    func testArticleTableView() {
        
        let app = XCUIApplication()
        app.launch()
        let articleTableView = app.tables["articles-tableView"]
        
        let tableCells = articleTableView.cells
        
        wait(forElement: tableCells.element, timeout: 20)
        
        if tableCells.count > 0 {

            let count = 10
            let promise = expectation(description: "Waiting for tableview cells")
            for i in stride(from: 0, to: count, by: 1) {
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "Article cell exists")

                tableCell.tap()

                if i == count - 1 {
                    promise.fulfill()
                }
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }

            waitForExpectations(timeout: 20) { error in
                XCTAssertTrue(true, "Finished validating tableview cells")
            }
        }
    }
    
    func wait(forElement element: XCUIElement, timeout: TimeInterval) {
        let predicate = NSPredicate(format: "exists == 1")
        expectation(for: predicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout)
    }
}
