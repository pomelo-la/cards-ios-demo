//
//  WidgetTableViewCell.swift
//  PomeloCardsDemo
//

import UIKit
import PomeloUI
import PomeloCards

class WidgetTableViewCell: UITableViewCell {
    
    static let identifier = "WidgetTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = PomeloUIGateway.shared.theme.colors.primary
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        self.contentView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor , constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
}
