//
//  ViewController.swift
//  PomeloCardsDemo
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel: WidgetViewModelProtocol = {
        WidgetViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        registerCells()
    }
    
    private func registerCells() {
        tableView.register(WidgetTableViewCell.self,
                           forCellReuseIdentifier: WidgetTableViewCell.identifier)
    }
    
    private func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate,
                          UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 4 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = viewModel.launchWidgetController(by: indexPath.row) else { return }
        self.present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WidgetTableViewCell.identifier,
            for: indexPath
        ) as? WidgetTableViewCell else { return WidgetTableViewCell() }
        switch indexPath.row {
            case CollectionViewCellTypes.cardActivation.rawValue:
                cell.configCell(.cardActivation)
            case CollectionViewCellTypes.changePin.rawValue:
                cell.configCell(.changePin)
            case CollectionViewCellTypes.card.rawValue:
                cell.configCell(.card)
            case CollectionViewCellTypes.cardDetail.rawValue:
                cell.configCell(.cardDetail)
        default: break
        }
        return cell
    }
}

