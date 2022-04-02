//
//  FooterLoaderView.swift
//  NYTimes
//
//  Created by Vijith TV on 01/04/22.
//

import UIKit

class FooterLoaderView: UIView {
    
    //MARK: - PROPERTIES

    var activityIndicator: UIActivityIndicatorView?
    
    //MARK: - INITIALIZERS

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupIndictorView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - SETUP INDICATOR VIEW

    private func setupIndictorView() {
        
        if activityIndicator == nil {
            activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator?.center = self.center
            self.addSubview(activityIndicator!)
            activityIndicator?.startAnimating()
        }
    }
    
    //MARK: - REMOVE INIDCATOR VIEW

    func removeIndicatorView() {
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}
