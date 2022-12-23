//
//  ViewController.swift
//  PomeloCardsDemo
//
import UIKit

/// Initial screen of the App
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: WidgetViewModelProtocol = WidgetViewModel()
    
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 4 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = viewModel.getWidgetController(by: indexPath.row) else { return }
        self.present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WidgetTableViewCell.identifier,
            for: indexPath
        ) as? WidgetTableViewCell else { return WidgetTableViewCell() }
        guard let type = TableViewCellType(rawValue: indexPath.row) else { return WidgetTableViewCell() }
        cell.configCell(type)
        return cell
    }
}

