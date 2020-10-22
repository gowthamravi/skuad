//
//  DetailViewController.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/22/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loaderView: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        scrollView.delegate = self
         NotificationCenter.default.addObserver(self, selector: #selector(loadImage(_:)), name: NSNotification.Name("LoadImage") , object: nil)
        
    }
    
    @objc func loadImage (_ notification: Notification) {
        guard let photo = notification.object as? Hits else {
            return
        }
        self.loaderView.startAnimating()
        
        if let photourl = URL(string: photo.largeImageURL!){
            DispatchQueue.main.async {
                self.imageView.af.setImage(withURL: photourl) { _ in
                    self.loaderView.stopAnimating()
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        for view in scrollView.subviews where view is UIImageView {
            return view as! UIImageView
        }
        return nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

