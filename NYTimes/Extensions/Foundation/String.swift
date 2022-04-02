//
//  String.swift
//  NYTimes
//
//  Created by Vijith TV on 30/03/22.
//

import Foundation

extension String {
    
    //MARK: - FORMATTED DATE
    
    var dateFromString: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return dateFormatter.date(from: self)
    }
    
    //MARK: - ARTICLE PUBLISHED DATE

    func publishedDate() -> String {
        guard let date = self.dateFromString else { return "" }
        guard let newDate = date.articleDate else { return "" }
        return newDate
    }
}
