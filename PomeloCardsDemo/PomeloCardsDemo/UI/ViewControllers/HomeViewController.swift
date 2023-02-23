//
//  ViewController.swift
//  PomeloCardsDemo
//
import UIKit

/// Initial screen of the App
class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let widgetsFactory = WidgetViewControllerFactory()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        WidgetType.count
    }
    
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
