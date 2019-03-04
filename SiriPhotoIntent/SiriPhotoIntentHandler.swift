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
//        let photoInfoController = PhotoInfoController()
//        photoInfoController.fetchPhotoOfTheDay { (photoInfo) in
//            if let photoInfo = photoInfo {
//                if photoInfo.isImage {
//                    completion(IntentIntentResponse(code: .ready, userActivity: nil))
//                } else {
//                    completion(IntentIntentResponse(code: .failureNoImage, userActivity: nil))
//                }
//            }
//        }
        
    }
    
    func handle(intent: IntentIntent, completion: @escaping (IntentIntentResponse) -> Void) {
//        let photoInfoController =
//        photoInfoController.fetchPhotoOfTheDay { (photoInfo) in
//            if let photoInfo = photoInfo {
//                completion(IntentIntentResponse.success(photoTitle: photoInfo.title))
//            }
//        }
    }
}
