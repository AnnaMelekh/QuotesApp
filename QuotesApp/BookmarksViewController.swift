//
//  BookmarksViewController.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 23.02.2025.
//

import UIKit

final class BookmarksViewController: UIViewController {
    
    private lazy var searchBar = UISearchBar()
    private lazy var tableView = UITableView()

    var quotes: [QuoteModel] = []
    var filteredQuotes: [String] = []
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()

    }
    
}

private extension BookmarksViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search for the quotes..."
        
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            searchBar.heightAnchor.constraint(equalToConstant: 90),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(QuoteCell.self, forCellReuseIdentifier: "QuoteCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell
        cell.configure(with: quotes[indexPath.row])
        return cell
    }
}

extension BookmarksViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            filteredQuotes = quotes
//        } else {
//            filteredQuotes = quotes.filter { $0.lowercased().contains(searchText.lowercased()) }
//        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}


