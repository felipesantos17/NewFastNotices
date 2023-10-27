//
//  NewsListView.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import UIKit

final class NewsListView: UIView {
    
    lazy var newsListLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.textColor = .purple
        label.text = "Pasteis de frango"
        return label
    }()
    
    lazy var newsListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.addTableView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configTableViewPotocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.newsListTableView.delegate = delegate
        self.newsListTableView.dataSource = dataSource
    }
    
    func updateTableView() {
        self.newsListTableView.reloadData()
    }
    
    private func configBackGround(){
        self.backgroundColor = .white
    }
    
    private func addTableView() {
        self.addSubview(self.newsListLabel)
        self.addSubview(self.newsListTableView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            self.newsListLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.newsListLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.newsListLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            self.newsListTableView.topAnchor.constraint(equalTo: self.newsListLabel.bottomAnchor, constant: 10),
            self.newsListTableView.leftAnchor.constraint(equalTo: self.newsListLabel.leftAnchor),
            self.newsListTableView.rightAnchor.constraint(equalTo: self.newsListLabel.rightAnchor),
            self.newsListTableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
