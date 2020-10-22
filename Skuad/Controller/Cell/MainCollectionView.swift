//
//  CollectionViewCell.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/16/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import UIKit
import Alamofire


class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
}

extension UICollectionViewCell {

    static var identifier: String {
        return String(describing: self)
    }
}

