//
//  ProductDetailHeaderCell.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import Foundation
import UIKit

class ProductDetailHeaderCell: UITableViewHeaderFooterView {
    
    private struct Constants {
        static let stackViewSpacing: CGFloat = 10
        static let fontProductTitle: CGFloat = 20
        static let fontLabelPrice: CGFloat = 16
    }
    
    // MARK: - Private properties -
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = Constants.stackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var productImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var productTitle: UILabel = {
        let title = UILabel()
        title.numberOfLines = .zero
        title.textAlignment = .center
        title.textColor = AppColors.purple.color
        title.font = UIFont.boldSystemFont(ofSize: Constants.fontProductTitle)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var containerPrice: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.distribution = .fill
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var labelPrice: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = AppColors.purple.color
        label.text = Strings.products.price
        label.font = UIFont.boldSystemFont(ofSize: Constants.fontLabelPrice)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let price = UILabel()
        price.textAlignment = .center
        price.numberOfLines = .zero
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()
    
    // MARK: - Lifecycle -
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Public methods -
    
    func config(model: ProductEntity) {
        guard let title = model.title,
              let price = model.price,
              let image = model.image,
              let url = URL(string: image) else { return }
        productTitle.text = title
        productPrice.text = price
        productImage.load(url: url)
        validateOrientation()
    }
    
    // MARK: - Private methods -
    
    private func setupView() {
        validateOrientation()
        addStackViewToView()
        addProductImageToView()
        addProductTitleToView()
        addContainerPriceToView()
        addLabelPriceToView()
        addProductPricetoView()
    }
    
    private func validateOrientation() {
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
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
    
    private func addProductImageToView() {
        stackView.addArrangedSubview(productImage)
        NSLayoutConstraint.activate([
            productImage.heightAnchor.constraint(equalToConstant: 150),
            productImage.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func addProductTitleToView() {
        stackView.addArrangedSubview(productTitle)
        NSLayoutConstraint.activate([
            productTitle.heightAnchor.constraint(equalToConstant: 50),
            productTitle.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func addContainerPriceToView() {
        stackView.addArrangedSubview(containerPrice)
        NSLayoutConstraint.activate([
            containerPrice.heightAnchor.constraint(equalToConstant: 50),
            containerPrice.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func addLabelPriceToView() {
        containerPrice.addArrangedSubview(labelPrice)
    }
    
    private func addProductPricetoView() {
        containerPrice.addArrangedSubview(productPrice)
    }
}
