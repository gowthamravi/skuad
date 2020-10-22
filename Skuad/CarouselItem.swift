//
//  CarouselItem.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/15/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CarouselItem: UIView,UIScrollViewDelegate {
    static let CAROUSEL_ITEM_NIB = "CarouselItem"
    
    @IBOutlet var vwContent: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    convenience init(photo: Hits) {
        self.init()
        self.loaderView.startAnimating()
        if let photourl = URL(string: photo.largeImageURL!){
            DispatchQueue.main.async {
                self.imageView.af.setImage(withURL: photourl) { _ in
                    self.loaderView.stopAnimating()
                }
            }
        }
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.CAROUSEL_ITEM_NIB, owner: self, options: nil)
        vwContent.frame = bounds
        vwContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(vwContent)
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for view in scrollView.subviews where view is UIImageView {
            return view as! UIImageView
        }
        return nil
    }
}

   

