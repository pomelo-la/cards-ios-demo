//
//  CardStoryboardViewController.swift
//  PomeloCardsDemo
//
//  Created by Fernando Pena on 23/12/2022.
//

import Foundation
import UIKit
import PomeloCards
import PomeloUI

/// Example - ViewController that contains the view `PomeloCardWidgetView`
class CardStoryboardViewController: UIViewController {
    var cardId: String
    
    init?(coder: NSCoder, cardId: String) {
        self.cardId = cardId
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a cardId.")
    }
    
    @IBOutlet weak var pomeloCardView: PomeloCardWidgetView!
    
    @IBAction func showCardData() {
        pomeloCardView.showSensitiveData(cardId: cardId, onPanCopy: {
            print("Pan was coppied")
        }, completionHandler: { result in
            switch result {
            case .success(): break
            case .failure(let error):
                print("Sensitive data error: \(error)")
                self.dismiss(animated: true)
            }
        })
    }
    
    func setupPomeloCardView(cardholderName: String,
                             lastFourCardDigits: String,
                             cardImage: UIImage? = nil) {
        // Configure Pomelo card view
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = PomeloUIGateway.shared.theme.colors.background
    }
}

