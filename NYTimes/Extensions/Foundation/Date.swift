//
//  Date.swift
//  NYTimes
//
//  Created by Vijith TV on 30/03/22.
//

import Foundation

extension Date {
    
    //MARK: - ARTICLE FORMATTED DATE

    var articleDate: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd yyyy"
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }
}
