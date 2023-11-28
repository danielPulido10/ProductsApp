//
//  HomeViewController.swift
//  ProductsApp
//
//  Created by Daniel Alejandro Pulido Sepulveda on 22/11/23.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    private struct Constants {
        static let titleFontHeight: CGFloat = 30
        static let descriptionFontHeight: CGFloat = 18
        static let nameImageView: String = "HomeImageCar"
        static let cornerRadiusSearchButton: CGFloat = 10
        static let multiplierDescriptionText: CGFloat = 1
    }
    
    // MARK: - Public properties -
    
    var presenter: HomePresenterProtocol?
    
    // MARK: - Private properties -
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.isScrollEnabled = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var titleText: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: Constants.titleFontHeight)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = Strings.home.title
        return title
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private lazy var descriptionText: UILabel = {
        let description = UILabel()
        description.textColor = .black
        description.numberOfLines = .zero
        description.textAlignment = .center
        description.contentMode = .top
        description.font = UIFont.systemFont(ofSize: Constants.descriptionFontHeight)
        description.translatesAutoresizingMaskIntoConstraints = false
        description.text = Strings.home.description
        return description
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.nameImageView)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var searchButton: UIButton = {
        let search = UIButton()
        search.setTitle(Strings.home.searchProducts, for: .normal)
        search.tintColor = AppColors.white.color
        search.backgroundColor = AppColors.purple.color
        search.layer.cornerRadius = Constants.cornerRadiusSearchButton
        search.addTarget(self, action: #selector(searchActionButton), for: .touchUpInside)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    private var heightDescriptionText: NSLayoutConstraint = NSLayoutConstraint()
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addScrollViewToView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        validateScreenOrientation()
    }
    
    // MARK: - Private methods -
    
    private func addViews() {
        addTitleTextToView()
        addstackViewToView()
        addImageViewToView()
        addContainerViewToView()
        addDescriptionTextToView()
        addSearchButtonToView()
        validateScreenOrientation()
    }
    
    private func validateScreenOrientation() {
        if UIDevice.current.orientation.isLandscape {
            stackView.axis = .horizontal
        } else {
            stackView.axis = .vertical
        }
    }
    
    private func addScrollViewToView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    private func addTitleTextToView() {
        scrollView.addSubview(titleText)
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            titleText.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            titleText.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            titleText.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 20),
            titleText.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addstackViewToView() {
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 10),
            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30)
        ])
    }
    
    private func addImageViewToView() {
        stackView.addArrangedSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant:300),
            imageView.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    private func addContainerViewToView() {
        stackView.addArrangedSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func addDescriptionTextToView() {
        containerView.addSubview(descriptionText)
        NSLayoutConstraint.activate([
            descriptionText.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            descriptionText.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            descriptionText.leftAnchor.constraint(equalTo: containerView.rightAnchor),
            descriptionText.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            descriptionText.heightAnchor.constraint(equalToConstant: 80),
        ])
    }
    
    private func addSearchButtonToView() {
        containerView.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            searchButton.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    @objc func searchActionButton(sender: UIButton!) {
        guard let presenter else { return }
        presenter.goToSearchProductScreen()
    }
}
