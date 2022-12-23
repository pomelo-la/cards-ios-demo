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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { viewModel.widgetsCount() }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let widgetType = WidgetType(rawValue: indexPath.row) else { return }
        viewModel.presentWidget(widgetType, on: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WidgetTableViewCell.identifier,
                                                       for: indexPath) as? WidgetTableViewCell,
              let widgetType = WidgetType(rawValue: indexPath.row) else {
            print("Couldn't generate cell at indexPath: \(indexPath)")
            return WidgetTableViewCell()
        }
        viewModel.configCell(cell, widget: widgetType)
        return cell
    }
}

