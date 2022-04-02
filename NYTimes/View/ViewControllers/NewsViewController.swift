//
//  NewsViewController.swift
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import UIKit

enum Section {
    case main
}

class NewsViewController: UIViewController, Loadable {
    
    //MARK: - IBOUTLETS

    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - PROPERTIES
    
    /* TITLE LABEL */
    private var titleLabel: NavigationTitleLabel!
    
    
    /* ARTICLE VIEWMODEL */
    private lazy var viewmodel: ArticlesViewModel = {
        ArticlesViewModel(networkLayer: GetArticlesNetworkLayer(networkClient: NetworkClient()))
    }()

    
    /* TYPE ALIAS*/
    typealias ARTICLESDATASOURCE = UITableViewDiffableDataSource<Section, Docs>
    typealias ARTICLESNAPSHOT = NSDiffableDataSourceSnapshot<Section, Docs>
    
    /* DATASOURCE */
    lazy var datasource = makeDatasource()
    
    /* SNAPSHOT */
    var articleSnapshot = ARTICLESNAPSHOT()
    
    /* FOOTER VIEW */
    var footerLoaderView: FooterLoaderView?

    //MARK: - VIEW LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTitle()
        setupTableView()
        setupViewmodel()
        
    }
    
    //MARK: - SETUP TITLE LABEL

    private func setupTitle () {
        titleLabel = NavigationTitleLabel(frame: .zero)
        titleLabel.accessibilityLabel = "navigationTitleLabel"
        titleLabel.accessibilityIdentifier = "navigation-titleLabel"
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
        self.navigationItem.titleView = titleLabel
    }
    
    //MARK: - SETUP TABLEVIEW

    private func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ArticleCell.nib, forCellReuseIdentifier: ArticleCell.identifier)
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.isPrefetchingEnabled = true
        tableView.prefetchDataSource = self
        tableView.separatorStyle = .none
        tableView.accessibilityLabel = "articlesTableView"
        tableView.accessibilityIdentifier = "articles-tableView"
    }
    
    //MARK: - CONFIGURE VIEWMODEL

    private func setupViewmodel() {
        
        self.showHUD()
        viewmodel.fetchArticles()
        viewmodel.articleDocs.bind { [weak self] docs in
            guard !docs.isEmpty else { return }
            DispatchQueue.main.async {
                self?.dismissHUD()
                self?.applyArticleSnapshot(docs, isPaginating: self?.viewmodel.tableViewDiff ?? false)
                guard let tableViewDiffing = self?.viewmodel.tableViewDiff, tableViewDiffing else { return }
                self?.tableView.tableFooterView = nil
            }
        }
        
        viewmodel.errorMessage.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.tableFooterView = nil
            }
        }
    }
    
    //MARK: - MAKE DATASOURCE
    
    private func makeDatasource() -> ARTICLESDATASOURCE {
        let datasource = ARTICLESDATASOURCE(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell else { fatalError("NO PROTOTYPE CELL FOUND") }
            cell.set(doc: item)
            return cell
        }
      return datasource
    }
    
    //MARK: - APPLY SNAPSHOT
    
    private func applyArticleSnapshot(_ entity: [Docs], isPaginating: Bool = false) {
        if !isPaginating {
            articleSnapshot.deleteAllItems()
            articleSnapshot.appendSections([.main])
        }
        articleSnapshot.appendItems(entity, toSection: .main)
        datasource.apply(articleSnapshot, animatingDifferences: false, completion: nil)
    }
    
    //MARK: - PERFORM SEGUE WITH IDENTIFIER

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let newsDetialsVC = segue.destination as? NewsDetailsViewController else { return }
        guard let articleDocs = sender as? Docs else { return }
        newsDetialsVC.articleDocs = articleDocs
    }
    
    //MARK: - TABLE VIEW PAGINATION LOGICS

    func tableViewPagination() {
        let currentPage = viewmodel.totalElements / viewmodel.batchSize
        guard !viewmodel.pageLoaded.contains(currentPage) else { return }
        tableView.tableFooterView = createFooterLoaderView()
        viewmodel.paginateArticles(page: currentPage)
    }
    
    //MARK: - CREATE FOOTER VIEW WITH ACTIVITY LOADER

    func createFooterLoaderView() -> FooterLoaderView?  {
        guard let footerLoaderView = footerLoaderView else {
            footerLoaderView = FooterLoaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
            return footerLoaderView
        }
        return footerLoaderView
    }
}

//MARK: - NEWS VIEW CONTROLLER EXTENSION FOR UITABLEVIEW DELEGATE

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let doc = articleSnapshot.itemIdentifiers[indexPath.row]
        self.performSegue(withIdentifier: SegueIds.articleDetailsSegue.rawValue, sender: doc)
    }
    
}

//MARK: - NEWS VIEW CONTROLLER EXTENSION FOR UITABLEVIEW PREFETCH DATASOURCE

extension NewsViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        indexPaths.forEach {
            if articleSnapshot.itemIdentifiers.indices.contains($0.row) {
                let imageURLs = articleSnapshot.itemIdentifiers.compactMap {
                    URL(string: $0.getImageURL(type: .largeHorizontal375))
                }
                viewmodel.preFetchImages(imageURLs: imageURLs)
            }
        }
    }
}

//MARK: - NEWS VIEW CONTROLLER EXTENSION FOR UITABLEVIEW DELEGATE

extension NewsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - scrollView.frame.size.height) - viewmodel.scrollOffset {
            tableViewPagination()
        } else {
            viewmodel.cancelPrefetch()
        }
    }
}
