//
//  SiriPhotoIntentHandler.swift
//  SiriPhotoIntent
//
//  Created by Hellen Soloviy on 3/4/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation

class SiriPhotoIntentHandler: NSObject, IntentIntentHandling {
    
    func confirm(intent: IntentIntent, completion: @escaping (IntentIntentResponse) -> Void) {
        if let _ = intent.textToSearchFor {
            completion(IntentIntentResponse(code: .ready, userActivity: nil))
        } else {
            completion(IntentIntentResponse(code: .unspecified, userActivity: nil))
        }
    }
    
    func handle(intent: IntentIntent, completion: @escaping (IntentIntentResponse) -> Void) {
        if let textToSearch = intent.textToSearchFor {
            Flickr().searchFlickr(for: textToSearch) { (searchResults) in
                switch searchResults {
                case .error(let _) :
                    completion(IntentIntentResponse(code: .failure, userActivity: nil))
                case .results(let results):
                    let count = NSNumber.init(value: results.searchResults.count)
                   completion(.success(resultsCount: count, searchedText: textToSearch))
                }
            }
        } else {
            completion(IntentIntentResponse(code: .unspecified, userActivity: nil))
        }
    }
}
