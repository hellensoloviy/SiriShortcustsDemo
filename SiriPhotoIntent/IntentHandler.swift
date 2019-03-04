//
//  IntentHandler.swift
//  SiriPhotoIntent
//
//  Created by Hellen Soloviy on 3/4/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return SiriPhotoIntentHandler()
    }
    
}

