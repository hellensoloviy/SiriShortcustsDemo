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
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    private var searches: [FlickrSearchResults] = []
    private let flickr = Flickr()
    
}

// MARK: - Private
private extension PicsColllectionViewController {
    func photo(for indexPath: IndexPath) -> FlickrPhoto {
        return searches[indexPath.section].searchResults[indexPath.row]
    }
}
