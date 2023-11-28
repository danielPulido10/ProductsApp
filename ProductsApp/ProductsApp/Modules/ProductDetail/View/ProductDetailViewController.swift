//
//  ProductDetailViewController.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 27/11/23.
//

import Foundation
import UIKit

class ProductDetailViewController: BaseViewController {
    
    private struct Constants {
        static let heightCell: CGFloat = 30
    }
    
    // MARK: - Public properties -
    
    var presenter: ProductDetailPresenterProtocol?
    
    // MARK: - Private properties -
    
    private lazy var productTable: UITableView = {
        let product = UITableView()
        product.backgroundColor = .clear
        product.separatorStyle = .singleLine
        product.separatorColor = AppColors.purple.color
        product.translatesAutoresizingMaskIntoConstraints = false
        product.dataSource = self
        product.delegate = self
        return product
    }()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        productTable.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        productTable.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    // MARK: - Private methods -
    
    private func setupView() {
        addProductTableToView()
        registerCellInTableView()
    }
    
    private func registerCellInTableView() {
        productTable.register(ProductDetailHeaderCell.self,
                              forHeaderFooterViewReuseIdentifier: ProductDetailHeaderCell.viewID)
        productTable.register(ProductDetailViewCell.self,
                              forCellReuseIdentifier: ProductDetailViewCell.viewID)
    }
    
    private func addProductTableToView() {
        view.addSubview(productTable)
        NSLayoutConstraint.activate([
            productTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            productTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            productTable.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
            productTable.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -15),
            productTable.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            productTable.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30),
        ])
    }
}

// MARK: - UITableViewDataSource UITableViewDelegate -

extension ProductDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter else { return .zero }
        return presenter.getAttributesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter,
              let model = presenter.getAttributeInfo(for: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailViewCell.viewID, for: indexPath) as? ProductDetailViewCell else {
            return UITableViewCell()
        }
        cell.config(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let presenter,
              let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProductDetailHeaderCell.viewID) as? ProductDetailHeaderCell else { return nil }
        cell.config(model: presenter.getModel())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightCell
    }
}
