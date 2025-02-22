//
//  CategoryViewController.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 22.02.2025.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Choose your favourite category"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "you can select more than one"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var familyButton = createButton(title: "Family")
    private lazy var friendsButton = createButton(title: "Friendship")
    private lazy var workButton = createButton(title: "Success")
    private lazy var healthButton = createButton(title: "Health")
    private lazy var loveButton = createButton(title: "Love")
    private lazy var otherButton = createButton(title: "Happiness")
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            familyButton, friendsButton, workButton, healthButton, loveButton, otherButton
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "you can change it later"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("done", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .black
        button.backgroundColor = UIColor(named: "green1")
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        
        navigationItem.title = "Categories"    }
    
    
}

private extension CategoryViewController {
    
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(buttonsStack)
        view.addSubview(bottomLabel)
        view.addSubview(doneButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            buttonsStack.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40),
            buttonsStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            
            
            bottomLabel.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 20),
            bottomLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bottomLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            doneButton.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 20),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 100),
            doneButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = UIColor(named: "grey1")
        button.tintColor = .systemGray
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        
        return button
    }
    
    
    @objc func categoryButtonTapped(_ sender: UIButton) {
            familyButton.isSelected = false
            friendsButton.isSelected = false
            workButton.isSelected = false
            healthButton.isSelected = false
            loveButton.isSelected = false
            otherButton.isSelected = false

            sender.backgroundColor = UIColor(named: "green1")

            switch sender {
            case familyButton:
                friendsButton.backgroundColor = UIColor(named: "grey1")
                workButton.backgroundColor = UIColor(named: "grey1")
                healthButton.backgroundColor = UIColor(named: "grey1")
                loveButton.backgroundColor = UIColor(named: "grey1")
                otherButton.backgroundColor = UIColor(named: "grey1")
             case friendsButton:
                familyButton.backgroundColor = UIColor(named: "grey1")
                workButton.backgroundColor = UIColor(named: "grey1")
                healthButton.backgroundColor = UIColor(named: "grey1")
                loveButton.backgroundColor = UIColor(named: "grey1")
                otherButton.backgroundColor = UIColor(named: "grey1")
             case workButton:
                familyButton.backgroundColor = UIColor(named: "grey1")
                friendsButton.backgroundColor = UIColor(named: "grey1")
                healthButton.backgroundColor = UIColor(named: "grey1")
                loveButton.backgroundColor = UIColor(named: "grey1")
                otherButton.backgroundColor = UIColor(named: "grey1")
             case healthButton:
                familyButton.backgroundColor = UIColor(named: "grey1")
                friendsButton.backgroundColor = UIColor(named: "grey1")
                workButton.backgroundColor = UIColor(named: "grey1")
                loveButton.backgroundColor = UIColor(named: "grey1")
                otherButton.backgroundColor = UIColor(named: "grey1")
             case loveButton:
                familyButton.backgroundColor = UIColor(named: "grey1")
                friendsButton.backgroundColor = UIColor(named: "grey1")
                workButton.backgroundColor = UIColor(named: "grey1")
                healthButton.backgroundColor = UIColor(named: "grey1")
                otherButton.backgroundColor = UIColor(named: "grey1")
             default:
                familyButton.backgroundColor = UIColor(named: "grey1")
                friendsButton.backgroundColor = UIColor(named: "grey1")
                workButton.backgroundColor = UIColor(named: "grey1")
                healthButton.backgroundColor = UIColor(named: "grey1")
                loveButton.backgroundColor = UIColor(named: "grey1")
             }
    }
    
    @objc func doneTapped() {
        tabBarController?.selectedIndex = 1
        navigationController?.popToRootViewController(animated: true)

    }
}

#Preview { CategoryViewController() }


