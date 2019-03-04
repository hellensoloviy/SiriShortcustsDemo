//
//  PicsColllectionViewController.swift
//  SiriShortcustsDemo
//
//  Created by Hellen Soloviy on 3/4/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation
import UIKit

class PicsColllectionViewController: UICollectionViewController {
    // MARK: - Properties
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 12.0, bottom: 50.0, right: 12.0)
    
    //search results will be limited to 20 
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()
    private let itemsPerRow: CGFloat = 3
    
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searches.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searches[section].searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewItem.identifier, for: indexPath) as! PicCollectionViewItem
        //config the cell
        let flickrPhoto = photo(for: indexPath)
        cell.backgroundColor = .white
        cell.imageView.image = flickrPhoto.thumbnail
        return cell
    }
    
    
}

// MARK: - Collection View Flow Layout Delegate
extension PicsColllectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}


// MARK: - Private
private extension PicsColllectionViewController {
    func photo(for indexPath: IndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
}

// MARK: - Text Field Delegate
extension PicsColllectionViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //show indicator
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        flickr.searchFlickr(for: textField.text!) { searchResults in
            activityIndicator.removeFromSuperview()
            
            switch searchResults {
            case .error(let error) :
                print("HS__ Error Searching: \(error)")
            case .results(let results):
                print("HS__ Found \(results.searchResults.count) matching \(results.searchTerm)")
                self.searches.insert(results, at: 0)
                self.collectionView?.reloadData()
            }
        }
        
        textField.text = nil
        textField.resignFirstResponder()
        return true
    }
}
