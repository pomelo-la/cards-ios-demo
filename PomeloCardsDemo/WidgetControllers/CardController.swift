//
//  CardController.swift
//  PomeloCardsDemo
//

import Foundation
import UIKit
import PomeloCards

class CardController: UIViewController {
    let cardWidgetView: PomeloCardWidgetView
    let cardId: String

    init(cardWidgetView: PomeloCardWidgetView,
         cardId: String) {
        self.cardWidgetView = cardWidgetView
        self.cardId = cardId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var showDataButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Mostrar Datos", for: .normal)
        button.addTarget(self, action: #selector(showData), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @objc private func showData() {
        cardWidgetView.showSensitiveData(cardId: cardId, onPanCopy: {
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
    
    private func setupView() {
        setupUI()
        buildViewHierarchy()
        setupConstraints()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
    }
    
    private func buildViewHierarchy() {
        view.addSubviews(cardWidgetView,
                         showDataButton)
    }
    
    // MARK: - AutoLayout
    
    private func setupConstraints() {
        cardWidgetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardWidgetView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardWidgetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            cardWidgetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            cardWidgetView.heightAnchor.constraint(equalToConstant: 200),

            
            showDataButton.topAnchor.constraint(equalTo: cardWidgetView.bottomAnchor, constant: 24),
            showDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showDataButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}
