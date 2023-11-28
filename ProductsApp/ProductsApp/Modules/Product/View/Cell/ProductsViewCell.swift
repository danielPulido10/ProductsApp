//
//  ProductsViewCell.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation
import UIKit

class ProductsViewCell: UITableViewCell {
    
    private struct Constants {
        static let stackViewSpacing: CGFloat = 20
        static let nameNewIcon: String = "NewIcon"
        static let containerViewSpacing: CGFloat = 5
        static let fontTitleProduct: CGFloat = 16
    }
    
    // MARK: - Private properties -
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = Constants.stackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var containerImageView: UIView = {
        let containerImage = UIView()
        containerImage.translatesAutoresizingMaskIntoConstraints = false
        return containerImage
    }()
    
    private lazy var productImage: UIImageView = {
        let product = UIImageView()
        product.translatesAutoresizingMaskIntoConstraints = false
        return product
    }()
    
    private lazy var newIcon: UIImageView = {
        let new = UIImageView()
        new.image = UIImage(named: Constants.nameNewIcon)
        new.translatesAutoresizingMaskIntoConstraints = false
        return new
    }()
    
    private lazy var containerView: UIStackView = {
        let container = UIStackView()
        container.axis = .vertical
        container.distribution = .fillProportionally
        container.spacing = Constants.containerViewSpacing
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var titleProduct: UILabel = {
        let title = UILabel()
        title.numberOfLines = .zero
        title.textAlignment = .center
        title.textColor = AppColors.purple.color
        title.font = UIFont.boldSystemFont(ofSize: Constants.fontTitleProduct)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.text = Strings.products.price
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceProduct: UILabel = {
        let price = UILabel()
        price.textAlignment = .center
        price.numberOfLines = .zero
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    private var model: ProductEntity? = nil
    
    // MARK: - Private lifecycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public methods -
    
    func config(model: ProductEntity) {
        self.model = model
        setupInfo()
    }
    
    // MARK: - Private methods -
    
    private func setupView() {
        selectionStyle = .none
        addStackViewToView()
        addContainerImageViewToView()
        addProductImageToView()
        addNewIconToView()
        addContainerViewToView()
        addTitleProductToView()
        addPriceLabelToView()
        addPriceProductToView()
    }
    
    private func setupInfo() {
        guard let model,
              let title = model.title,
              let price = model.price,
              let image = model.image,
              let url = URL(string: image) else { return }
        titleProduct.text = title
        priceProduct.text = price
        productImage.load(url: url)
        newIcon.isHidden = !model.isNew
    }
    
    private func addStackViewToView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    private func addContainerImageViewToView() {
        stackView.addArrangedSubview(containerImageView)
        NSLayoutConstraint.activate([
            containerImageView.heightAnchor.constraint(equalToConstant: 150),
            containerImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func addProductImageToView() {
        containerImageView.addSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalTo: containerImageView.heightAnchor),
            productImage.widthAnchor.constraint(equalTo: containerImageView.widthAnchor)
        ])
    }
    
    private func addNewIconToView() {
        containerImageView.addSubview(newIcon)
        NSLayoutConstraint.activate([
            newIcon.topAnchor.constraint(equalTo: productImage.topAnchor, constant: 10),
            newIcon.leftAnchor.constraint(equalTo: productImage.leftAnchor, constant: 10),
            newIcon.heightAnchor.constraint(equalToConstant: 40),
            newIcon.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addContainerViewToView() {
        stackView.addArrangedSubview(containerView)
    }
    
    private func addTitleProductToView() {
        containerView.addArrangedSubview(titleProduct)
    }
    
    private func addPriceLabelToView() {
        containerView.addArrangedSubview(priceLabel)
    }
    
    private func addPriceProductToView() {
        containerView.addArrangedSubview(priceProduct)
    }
}
