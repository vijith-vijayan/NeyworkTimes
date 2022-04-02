//
//  ArticleDetailsViewModel.swift
//  NYTimes
//
//  Created by Vijith TV on 29/03/22.
//

import Foundation

protocol ArticleDetailsViewModelProtocol {
    var articleDocs: Observable<Docs>?{ get set }
}

class ArticleDetailsViewModel: ArticleDetailsViewModelProtocol {
   
    //MARK: - PROPERTIES
    var articleDocs: Observable<Docs>? = nil
    
    //MARK: - INITIALIZER
    init(with articleDoc: Docs?) {
        guard let doc = articleDoc else {
            return
        }
        self.articleDocs = Observable(doc)
    }
}

