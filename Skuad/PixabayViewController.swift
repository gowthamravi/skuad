//
//  ViewController.swift
//  Skuad
//
//  Created by Ravikumar, Gowtham on 10/13/20.
//  Copyright © 2020 Ravikumar, Gowtham. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PixabayViewController: UIViewController {
    
    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    var selectedIndexPath: IndexPath?
    var itemsPerRow: CGFloat = 3
    let sectionInsets = UIEdgeInsets(top: 10.0, left:10, bottom: 10.0, right: 10.0)
    
    var searchResults =  [Hits]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension PixabayViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, searchText.count > 0 else {
           return
        }
        self.fetchPixbay(for: searchText) { result in
            switch result {
            case .success(let model):
                self.searchResults = model.hits ?? []
                DispatchQueue.main.async {
                 self.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}



// MARK: UICollectionViewDataSource
extension PixabayViewController :UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.imageView.isUserInteractionEnabled = true
        if let photourl = URL(string: searchResults[indexPath.row].previewURL!){
            cell.imageView.af.setImage(withURL: photourl)
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension PixabayViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        self.perform(#selector(postNotification), with: nil, afterDelay: 0.1)
    }
    
    @objc func postNotification () {
        let photo = searchResults[selectedIndexPath!.row]
        NotificationCenter.default.post(name: NSNotification.Name("LoadImage"), object: photo)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let photourl = URL(string: searchResults[indexPath.row].previewURL!){
            (cell as! MainCollectionViewCell).imageView.af.setImage(withURL: photourl)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension PixabayViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 2)
        let availableWidth = (UIScreen.main.bounds.width - paddingSpace)
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 55)
    }
}
