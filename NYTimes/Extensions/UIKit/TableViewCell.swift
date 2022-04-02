//
//  TableViewCell.swift
//  YouGovRecruitment
//
//  Created by Vijith TV on 17/03/22.
//

import UIKit

extension UITableViewCell {

    //MARK: - COLLECTIONVIEW CELL IDENTIFIER
    static var identifier: String {
        return String(describing: self)
    }
    
    //MARK: - NIB

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
