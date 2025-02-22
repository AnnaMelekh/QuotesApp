//
//  ViewController.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 21.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var searchBar = UISearchBar()
    private lazy var tableView = UITableView()
    
    var quotes = [
        "The best way to spread Christmas cheer is singing loud for all to hear.",
        "Happiness is not something ready-made. It comes from your own actions."
    ]
    
    var filteredQuotes: [String] = []
    var isSearching = false
    
    
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
        
        view.addSubview(searchBar)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search for the quotes..."
        
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
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 90),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell
        cell.configure(with: quotes[indexPath.row])
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredQuotes = quotes
        } else {
            filteredQuotes = quotes.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}


#Preview {MainViewController() }
