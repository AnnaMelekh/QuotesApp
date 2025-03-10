//
//  ViewController.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 21.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var tableView = UITableView()
    var quotes: [QuoteModel] = []
    var networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
        setupNavbar()
        setupConstraints()
        networkService.delegate = self
        networkService.performRequest()
        
        
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
    
    @objc func bookmarkTapped(_ sender: UIButton) {
        var superview = sender.superview
            while let view = superview, !(view is QuoteCell) {
                superview = view.superview
            }

            guard let cell = superview as? QuoteCell,
                  let indexPath = tableView.indexPath(for: cell) else {
                return
            }

            let quote = quotes[indexPath.row]
            BookmarkManager.shared.saveQuote(quote)

            print("Quote saved:", quote)
        NotificationCenter.default.post(name: NSNotification.Name("QuoteAdded"), object: quote)


            sender.setImage(UIImage(named: "bookmarkFill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            sender.tintColor = UIColor.systemGray
        
    }
    
    @objc func refreshTapped(_ sender: UIButton) {
        networkService.performRequest()
        
        var superview = sender.superview
            while let view = superview, !(view is QuoteCell) {
                superview = view.superview
            }

            guard let cell = superview as? QuoteCell,
                  let indexPath = tableView.indexPath(for: cell) else {
                return
            }
        cell.bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        
    }
    
    @objc func categoriesButtonTapped() {
        let categoriesVC = CategoryViewController()
        navigationController?.pushViewController(categoriesVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteCell", for: indexPath) as! QuoteCell
        cell.configure(with: quotes[indexPath.row])
        
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        cell.refreshButton.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        
        return cell
    }
}

extension MainViewController: NetworkServiceDelegate {
    func didUpdateData(quotes: [QuoteModel]) {
        DispatchQueue.main.async {
            self.quotes = quotes
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error.localizedDescription)
    }
    
    
}




#Preview {MainViewController() }
