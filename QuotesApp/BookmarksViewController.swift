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

    var bookmarks: [QuoteModel] = []
    var filteredQuotes: [QuoteModel] = []
    var isSearching = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarks = BookmarkManager.shared.getSavedQuotes()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        searchBar.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(updateBookmarks), name: NSNotification.Name("QuoteAdded"), object: nil)
        tableView.reloadData()
        
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
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 1),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
    
    @objc func updateBookmarks() {
        bookmarks = BookmarkManager.shared.getSavedQuotes()
        tableView.reloadData()
    }
    
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredQuotes.count : bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell
        
        let dataSource = isSearching ? filteredQuotes : bookmarks

        guard indexPath.row < dataSource.count else { return cell }

        let quote = dataSource[indexPath.row]
        cell.configure(with: quote)

 
        cell.bookmarkButton.isHidden = true
        cell.refreshButton.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let quoteToDelete = bookmarks[indexPath.row]

            tableView.performBatchUpdates({
                bookmarks.remove(at: indexPath.row)
                BookmarkManager.shared.removeQuote(quoteToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: nil)
            
           
            }
        }
    }


extension BookmarksViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
                    isSearching = false
                    filteredQuotes = bookmarks
                } else {
                    isSearching = true
                    filteredQuotes = bookmarks.filter { quote in
                        quote.quote.lowercased().contains(searchText.lowercased()) ||
                        quote.author.lowercased().contains(searchText.lowercased())
                    }
                }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredQuotes = bookmarks
            tableView.reloadData()
        searchBar.resignFirstResponder()
    }
}


