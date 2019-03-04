//
//  IntentViewController.swift
//  SiriPhotoIntentUI
//
//  Created by Hellen Soloviy on 3/4/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>,
                       of interaction: INInteraction,
                       interactiveBehavior: INUIInteractiveBehavior,
                       context: INUIHostedViewContext,
                       completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        guard let currentIntent = interaction.intent as? IntentIntent else {
            completion(false, Set(), .zero)
            return
        }
        
        let width = self.extensionContext?.hostedViewMaximumAllowedSize.width ?? 320
        let desiredSize = CGSize(width: width, height: 300)
        
        // The intentHandlingStatus never changed to .ready for me. It did sometimes change to .success.
        // Maybe this is buggy or maybe I don't understand how this should work
        //
        // if interaction.intentHandlingStatus == .ready {
        //     // A view for the .ready state
        // } else if interaction.intentHandlingStatus == .success {
        //     // A view for the .success state
        // }
        
        activityIndicator.startAnimating()
        guard let text = currentIntent.textToSearchFor else {
            self.stop()
            return
        }
        
        Flickr().searchFlickr(for: text) { (searchResults) in
            switch searchResults {
            case .error(let error):
                self.stop()
                completion(false, parameters, CGSize(width: 400, height: 400))
            case .results(let results):
                let count = NSNumber.init(value: results.searchResults.count)
                completion(true, parameters, CGSize(width: 400, height: 400))
                self.stop(with: results.searchResults.first?.largeImage)
            }
        }
        
        
        completion(true, parameters, desiredSize)
    }
    
    private func stop(with image: UIImage? = nil) {
        let image = image ?? UIImage.init(named: "defaultPic")
        
        DispatchQueue.main.async {
            self.imageView.image = image
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    
    
}
