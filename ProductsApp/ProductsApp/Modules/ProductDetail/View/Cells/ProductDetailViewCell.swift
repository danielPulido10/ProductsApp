//
//  ProductDetailViewCell.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import Foundation
import UIKit

class ProductDetailViewCell: UITableViewCell {
    
    private struct Constants {
        static let stackViewSpacing: CGFloat = 10
        static let fontNameLabel: CGFloat = 16
    }
    
    // MARK: - Private properties -
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.spacing = Constants.stackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.textColor = AppColors.purple.color
        name.numberOfLines = .zero
        name.font = UIFont.boldSystemFont(ofSize: Constants.fontNameLabel)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var valueLabel: UILabel = {
        let value = UILabel()
        value.textAlignment = .center
        value.numberOfLines = .zero
        value.translatesAutoresizingMaskIntoConstraints = false
        return value
    }()
    
    // MARK: - Lifecycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public methods -
    
    func config(model: ProductAttribute) {
        nameLabel.text = model.title
        valueLabel.text = model.description
    }
    
    // MARK: - Private methods -
    
    private func setupView() {
        addStackViewToView()
        addNameLabelToView()
        addValueLabelToVIew()
    }
    
    private func addStackViewToView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func addNameLabelToView() {
        stackView.addArrangedSubview(nameLabel)
    }
    
    private func addValueLabelToVIew() {
        stackView.addArrangedSubview(valueLabel)
    }
}
