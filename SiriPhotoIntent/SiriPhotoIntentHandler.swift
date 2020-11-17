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
        if let defaults = UserDefaults.init(suiteName: Constants.UserDefaults.storageNameKey), let _ = defaults.object(forKey: Constants.UserDefaults.lastSearchedTextKey) as? String {
            completion(IntentIntentResponse(code: .ready, userActivity: nil))
        } else {
            completion(IntentIntentResponse(code: .noSearchRequest, userActivity: nil))
        }
    }
    
    func handle(intent: IntentIntent, completion: @escaping (IntentIntentResponse) -> Void) {
        if let defaults = UserDefaults.init(suiteName: Constants.UserDefaults.storageNameKey), let textToSearch = defaults.object(forKey: Constants.UserDefaults.lastSearchedTextKey) as? String {
            Flickr().searchFlickr(for: textToSearch) { (searchResults) in
                switch searchResults {
                case .error(_):
                    completion(IntentIntentResponse(code: .failure, userActivity: nil))
                case .results(let results):
                   completion(.success(searchedText: textToSearch))
                }
            }
        } else {
            completion(IntentIntentResponse(code: .noResult, userActivity: nil))
        }
    }
}
