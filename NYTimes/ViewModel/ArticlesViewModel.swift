//
//  ArticlesViewModel.swift
//  NYTimes
//
//  Created by Vijith TV on 29/03/22.
//

import Foundation
import SDWebImage

protocol ArticleViewModelProtocol {
    func fetchArticles()
    func setError(_ message: String)
    var articleDocs: Observable<[Docs]> { get  set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}

class ArticlesViewModel: ArticleViewModelProtocol {
    
    
    //MARK: - PROPERTIES

    /* ERROR MESSAGE */
    var errorMessage: Observable<String?> = Observable(nil)
    
    /* ERROR */
    var error: Observable<Bool> = Observable(false)

    /* NETWORK LAYER */
    private var networkLayer: GetArticlesNetworkLayer?
    
    /* DOCS */
    var articleDocs: Observable<[Docs]> = Observable([])
    
    /* INT */
    var totalElements: Int = 0
    private var pageNumber: Int = 0
    var batchSize: Int = 10
    
    /* CGFLOAT*/
    var scrollOffset: CGFloat = 100
    
    /* BOOL */
    private var isFetchInProgress: Bool = false
    var tableViewDiff: Bool = false
    
    /* ARRAY */
    var pageLoaded: [Int] = [0]
    
    //MARK: - INITIALISERS

    init(networkLayer: GetArticlesNetworkLayer) {
        self.networkLayer = networkLayer
    }
    
    //MARK: - FETCH ARTICLES

    func fetchArticles() {
        
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        
        Task {
            let articles = try await networkLayer?.getArticles(pageNumber)
            isFetchInProgress = false
            guard let docs = articles?.response?.docs else {
                errorMessage = Observable("NO DATA FOUND IN SEVER")
                return
            }
            totalElements += docs.count
            articleDocs.value = docs
            pageLoaded.append(pageNumber)
        }
    }
    
    //MARK: - SET ERROR

    func setError(_ message: String) {
        self.errorMessage.value = message
        self.error.value = true
    }
    
    
    //MARK: - PREFECTH AND CACHE IMAGE

    func preFetchImages(imageURLs: [URL]) {
        
        SDImageCache.shared.config.shouldUseWeakMemoryCache = true
        SDWebImagePrefetcher.shared.prefetchURLs(imageURLs, progress: nil) { skippedURLs, finishedURLs in
            
        }
    }
    
    //MARK: - STOP IMAGE PREFETCH

    func cancelPrefetch() {
        SDWebImagePrefetcher.shared.cancelPrefetching()
    }
    
    //MARK: - PAGINATION

    func paginateArticles(page: Int) {
        pageNumber = page
        tableViewDiff = true
        fetchArticles()
    }
}


extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
