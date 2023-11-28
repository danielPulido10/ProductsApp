//
//  ProductsViewController.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 26/11/23.
//

import Foundation
import UIKit

class ProductsViewController: BaseViewController {
    
    private struct Constants {
        static let stackViewSpacing: CGFloat = 30
        static let nameImageView: String = "SearchProducts"
        static let multiplierSearchBar: CGFloat = 1
        static let heightCell: CGFloat = 150
        static let nameErrorImage: String = "ErrorIcon"
        static let borderSearchBar: CGFloat = 2
        static let cornerradiusSearchBar: CGFloat = 10
        static let controlConstraintSearchBar: CGFloat = 20
    }
    
    // MARK: - Public properties -
    
    var presenter: ProductsPresenterProtocol?
    
    // MARK: - Private properties -
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.delegate = self
        search.backgroundColor = AppColors.white.color
        search.tintColor = AppColors.purple.color
        search.layer.cornerRadius = Constants.cornerradiusSearchBar
        search.layer.borderColor = AppColors.purple.color.cgColor
        search.layer.borderWidth = Constants.borderSearchBar
        search.searchTextField.textColor = AppColors.purple.color
        search.searchTextField.attributedPlaceholder = NSAttributedString(string: Strings.products.searchPlaceholder,
                                                                          attributes: [NSAttributedString.Key.foregroundColor : AppColors.purple.color])
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = Constants.stackViewSpacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var descriptionText: UILabel = {
        let description = UILabel()
        description.numberOfLines = .zero
        description.textAlignment = .center
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var productsTable: UITableView = {
        let products = UITableView()
        products.backgroundColor = .clear
        products.separatorStyle = .singleLine
        products.dataSource = self
        products.delegate = self
        products.separatorColor = AppColors.purple.color
        products.translatesAutoresizingMaskIntoConstraints = false
        return products
    }()
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.style = .large
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private var widthSearchBar: NSLayoutConstraint = NSLayoutConstraint()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        validateScreenOrientation()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        changeConstraints(size: size)
        validateScreenOrientation()
    }
    
    // MARK: - Private methods -
    
    private func setupView() {
        addSearchViewToView()
        addStackViewToView()
        addImageViewToView()
        addDescriptionTextToView()
        addProductsTableToView()
        addLoaderViewToView()
        setupInitialView()
        registerCellInTableView()
    }
    
    private func registerCellInTableView() {
        productsTable.register(ProductsViewCell.self,
                               forCellReuseIdentifier: ProductsViewCell.viewID)
    }
    
    private func setupInitialView() {
        loaderView.isHidden = true
        productsTable.isHidden = true
        setupImageAndDescriptionInitial()
    }
    
    private func setupImageAndDescriptionInitial() {
        imageView.image = UIImage(named: Constants.nameImageView)
        descriptionText.text = Strings.products.description
    }
    
    private func validateScreenOrientation() {
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
    
    private func addSearchViewToView() {
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            searchBar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 10),
            searchBar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10),
            searchBar.heightAnchor.constraint(equalToConstant: 30)
        ])
        widthSearchBar = createWidthConstraintSearchBar()
        searchBar.addConstraint(widthSearchBar)
    }
    
    private func addStackViewToView() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 30),
            stackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func addImageViewToView() {
        stackView.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant:250),
            imageView.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func addDescriptionTextToView() {
        stackView.addArrangedSubview(descriptionText)
    }
    
    private func addProductsTableToView() {
        stackView.addArrangedSubview(productsTable)
    }
    
    private func addLoaderViewToView() {
        stackView.addArrangedSubview(loaderView)
    }
    
    private func createWidthConstraintSearchBar() -> NSLayoutConstraint {
        NSLayoutConstraint(item: searchBar,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: .none,
                           attribute: .width,
                           multiplier: Constants.multiplierSearchBar,
                           constant: view.frame.width - Constants.controlConstraintSearchBar)
    }
    
    private func changeConstraints(size: CGSize) {
        widthSearchBar.constant = size.width - Constants.controlConstraintSearchBar
        searchBar.layoutIfNeeded()
    }
    
    private func showLoader() {
        imageView.isHidden = true
        descriptionText.isHidden = true
        productsTable.isHidden = true
        loaderView.isHidden = false
        loaderView.startAnimating()
    }
    
    private func showTableProducts() {
        productsTable.isHidden = false
        loaderView.isHidden = true
        loaderView.stopAnimating()
    }
    
    private func showInitialView() {
        imageView.isHidden = false
        descriptionText.isHidden = false
        productsTable.isHidden = true
        loaderView.isHidden = true
        loaderView.stopAnimating()
    }
}

// MARK: - UISearchBarDelegate -

extension ProductsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let presenter,
              let text = searchBar.text else { return }
        view.endEditing(true)
        showLoader()
        presenter.searchProduct(text: text)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

// MARK: - ProductViewProtocol -

extension ProductsViewController : ProductViewProtocol {
    func loadProductTable() {
        setupImageAndDescriptionInitial()
        productsTable.reloadData()
        showTableProducts()
    }
    
    func showErrorView(message: String) {
        descriptionText.text = message
        imageView.image = UIImage(named: Constants.nameErrorImage)
        showInitialView()
    }
}

// MARK: - UITableViewDataSource UITableViewDelegate -

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getProductsCount() ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let model = presenter.getProductInfo(for: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: ProductsViewCell.viewID, for: indexPath) as? ProductsViewCell else {
            return UITableViewCell()
        }
        cell.config(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter,
              let model = presenter.getProductInfo(for: indexPath)else { return }
        presenter.goToProductDetail(model: model)
        view.endEditing(true)
    }
}
