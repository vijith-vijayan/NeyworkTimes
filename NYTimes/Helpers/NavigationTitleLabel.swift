//
//  NavigationTitleLabel.swift
//  NYTimes
//
//  Created by Vijith TV on 30/03/22.
//

import UIKit

class NavigationTitleLabel: UILabel {
    
    //MARK: - INITIALIZERS

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    //MARK: - SETUP

    func setup() {
        self.font = UIFont(name: "Chomsky", size: 30)
        self.text = "The New York Times"
        self.textColor = .black
        self.textAlignment = .center
    }
}
