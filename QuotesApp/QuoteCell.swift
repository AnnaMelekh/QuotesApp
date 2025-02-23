//
//  YellowCell.swift
//  QuotesApp
//
//  Created by Anna Melekhina on 22.02.2025.
//

import UIKit

class QuoteCell: UITableViewCell {
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Optima", size: 14)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.text = "Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var quoteLabel = UILabel()
    private lazy var containerView = UIView()
    private lazy var bookmarkButton = UIButton(type: .system)
    private lazy var refreshButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(named: "yellow1") ?? UIColor.yellow
        containerView.layer.cornerRadius = 15
        contentView.addSubview(containerView)
        
        quoteLabel.translatesAutoresizingMaskIntoConstraints = false
        quoteLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        quoteLabel.textColor = .black
        quoteLabel.adjustsFontSizeToFitWidth = true
        quoteLabel.minimumScaleFactor = 0.7
        quoteLabel.numberOfLines = 7
        quoteLabel.textAlignment = .center
        quoteLabel.font = UIFont(name: "Optima", size: 18)
        containerView.addSubview(quoteLabel)
        
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.setImage(UIImage(named: "bookmark"), for: .normal)
        bookmarkButton.tintColor = .systemGray
        containerView.addSubview(bookmarkButton)
        
        refreshButton.translatesAutoresizingMaskIntoConstraints = false
        refreshButton.setImage(UIImage(named: "refresh"), for: .normal)
        refreshButton.tintColor = .systemGray
        containerView.addSubview(refreshButton)
        
        containerView.addSubview(authorLabel)
        
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalToConstant: 250),
            
            quoteLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            quoteLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            bookmarkButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            bookmarkButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            refreshButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            refreshButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 10),
            authorLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    func configure(with quote: QuoteModel) {
        quoteLabel.text = quote.quote
        authorLabel.text = quote.author
    }
}
