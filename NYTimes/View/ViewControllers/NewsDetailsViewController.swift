//
//  NewDetailsViewController.swift
//  NYTimes
//
//  Created by Vijith TV on 29/03/22.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    //MARK: - IBOUTLETS

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var articleHeadlineLabel: UILabel!
    @IBOutlet weak var articleSubheadlineLabel: UILabel!
    @IBOutlet weak var articleAuthorLabel: UILabel!
    @IBOutlet weak var articleSourceLabel: UILabel!
    @IBOutlet weak var articleLeadParagraphLabel: UILabel!
    @IBOutlet weak var articlePubDateLabel: UILabel!
    
    //MARK: - PROPERTIES

    /* ARTICLE DOCS */
    var articleDocs: Docs?
    
    /* ARTICLE DETAILS VIEW MODEL ("VIEWMODEL IS NOT REQUIRED FOR THIS CLASS" VIEW MODEL IS ADDED FOR KEEPING THE STRUCTRE AND IN FUTURE IF WE HAVE TO ADD SOME ADDITIONAL LOGICS TO THIS VC WE CAN ADD IT IN THE VIEWMODEL) */ 
    private var viewmodel: ArticleDetailsViewModel?
    
    
    //MARK: - VIEW LIFE CYCLE METHODS

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewmodel()
    }
    
    //MARK: - SETUP VIEWMODEL

    func setupViewmodel() {
        guard let articleDocs = articleDocs else {
            return
        }
        viewmodel = ArticleDetailsViewModel(with: articleDocs)
        viewmodel?.articleDocs?.bind({ [weak self] doc in
            self?.setupUI(with: doc)
        })
    }
    
    //MARK: - SETUP UI

    private func setupUI(with doc: Docs) {
        articleHeadlineLabel.text = doc.headline?.main
        articleSubheadlineLabel.text = doc.snippet
        articleSourceLabel.text = doc.source
        articleLeadParagraphLabel.text = doc.leadParagraph
        articleAuthorLabel.text = doc.authorFullName
        
        if let pubDate = doc.pubDate {
            articlePubDateLabel.text = pubDate.publishedDate()
        }
        let imageURL = doc.getImageURL(type: .largeHorizontal375)
        guard imageURL != "" else {
            headerImageView.isHidden = true
            return
        }
        headerImageView.setImage(from: imageURL)
    }
    
    //MARK: - BACK BUTTON PRESSED
    @IBAction func pressBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
