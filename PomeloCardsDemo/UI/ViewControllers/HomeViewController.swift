//
//  ViewController.swift
//  PomeloCardsDemo
//
import UIKit

/// Initial screen of the App
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let widgetsFactory = WidgetViewControllerFactory()
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { WidgetType.count }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let widget = WidgetType(rawValue: indexPath.row),
              let widgetViewController = widgetsFactory.buildWidgetController(for: widget, params: widget.getParams()) else {
            print("Couldn't select widget at indexPath: \(indexPath)")
            return
        }
        if widget == .cardDetail {
            self.displayViewControllerAsBottomSheet(widgetViewController)
        } else {
            self.present(widgetViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WidgetTableViewCell.identifier,
                                                       for: indexPath) as? WidgetTableViewCell,
              let widget = WidgetType(rawValue: indexPath.row) else {
            print("Couldn't generate cell at indexPath: \(indexPath)")
            return WidgetTableViewCell()
        }
        cell.titleLabel.text = widget.getTitle()
        return cell
    }
}

extension WidgetType {
    func getTitle() -> String {
        switch self {
        case .cardActivation: return "Activación de tarjeta"
        case .changePin: return "Cambio de pin"
        case .card: return "Tarjeta"
        case .cardDetail: return "Datos de tarjeta"
        }
    }
    
    func getParams() -> [String: Any] {
        switch self {
        case .cardActivation: return [:]
        case .changePin: return ["card_id": "crd-2H0AxFMF5XJGQqc6iSpUzMUS7Z3"]
        case .card: return ["card_id": "crd-2H0AxFMF5XJGQqc6iSpUzMUS7Z3"]
        case .cardDetail: return ["card_id": "crd-2H0AxFMF5XJGQqc6iSpUzMUS7Z3"]
        }
    }
}
    
