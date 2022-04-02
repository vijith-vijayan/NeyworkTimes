//
//  ArticleCell.swift
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import UIKit

class ArticleCell: UITableViewCell {

    //MARK: - IBOUTLETS

    @IBOutlet weak var articleHeadlineLabel: UILabel!
    @IBOutlet weak var articleSubHeadlineLabel: UILabel!
    @IBOutlet weak var articlePosterImageView: UIImageView!
    @IBOutlet weak var articleSourceLabel: UILabel!
    @IBOutlet weak var articlePubDateLabel: UILabel!
    
    //MARK: - PREPARE FOR SEGUE

    override func prepareForReuse() {
        super.prepareForReuse()
        articlePosterImageView.cancelDownload()
        articlePosterImageView.image = nil
    }
    
    //MARK: - SET ARTICLE OBJECT 

    func set(doc: Docs) {
        articleHeadlineLabel.text = doc.headline?.main
        articleSubHeadlineLabel.text = doc.snippet
        articleSourceLabel.text = doc.source
        articlePubDateLabel.text = doc.pubDate?.publishedDate()
        
        let imageURL = doc.getImageURL(type: .largeHorizontal375)
        articlePosterImageView.isHidden = imageURL.isEmpty
        articlePosterImageView.setImage(from: imageURL)//loadImage(from: imageURL)
    }
    
}
