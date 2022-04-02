//
//  UIImageView.swift
//  NYTimes
//
//  Created by Vijith TV on 28/03/22.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    //MARK: - LOAD IMAGE FROM SERVER OR CACHE

    func setImage(from url: String) {
        
        let cached = SDImageCache.shared.diskImageDataExists(withKey: url)
        if cached {
            self.image = SDImageCache.shared.imageFromCache(forKey: url)
        } else {
            let imageURL = URL(string: url)
            self.sd_setImage(with: imageURL, placeholderImage: placeHolderLandscapeImage, options: [.continueInBackground, .retryFailed, .refreshCached]) { image, error, cacheType, url in
                
            }
        }
    }
    
    //MARK: - PLACEHOLDER LANDSCAPE IMAGE
    var placeHolderLandscapeImage: UIImage? {
        return UIImage(named: "placeHolder")
    }
    
    //MARK: - CANCEL CURRENT IMAGE DOWNLOAD

    func cancelDownload() {
        //self.kf.cancelDownloadTask()
        self.sd_cancelCurrentImageLoad()
    }
    
}
