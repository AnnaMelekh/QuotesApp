//
//  ViewController.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 21.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    
    var quotes = [
        "The best way to spread Christmas cheer is singing loud for all to hear.",
        "Happiness is not something ready-made. It comes from your own actions."
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupNavbar()
        setupConstraints()
    }
    
    
}

private extension MainViewController {
    
    func setupUI() {
        view.backgroundColor = .white

    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(QuoteCell.self, forCellReuseIdentifier: "QuoteCell")
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupNavbar() {
        let imageView = UIImageView(image: UIImage(named: "titleImg"))
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        navigationItem.titleView = imageView
        
        let categoriesIcon = UIImage(named: "category")?.withRenderingMode(.alwaysOriginal)
        let categoriesButton = UIBarButtonItem(image: categoriesIcon,
                                               style: .plain,
                                               target: self,
                                               action: #selector(categoriesButtonTapped))
        
        navigationItem.rightBarButtonItem = categoriesButton
    }
    
    @objc func categoriesButtonTapped() {
        let categoriesVC = CategoryViewController()
        navigationController?.pushViewController(categoriesVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell
        cell.configure(with: quotes[indexPath.row])
        return cell
    }
}




#Preview {MainViewController() }
