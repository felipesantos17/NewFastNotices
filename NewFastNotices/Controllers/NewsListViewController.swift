//
//  NewsListViewController.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import UIKit

class NewsListViewController: UIViewController {
    
    private var localDataProvider: NewsListLocalDataProvider?
    private var newsListView: NewsListView?
    private var newsList: [NewsModel]? {
        didSet {
            self.newsListView?.updateTableView()
        }
    }

    override func loadView() {
        self.newsListView = NewsListView()
        self.view = newsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsListView?.configTableViewPotocols(delegate: self, dataSource: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initLocalDataProvider()
    }
    
    
    private func initLocalDataProvider() {
        self.localDataProvider = NewsListLocalDataProvider()
        self.localDataProvider?.delegate = self
        self.localDataProvider?.getNewsList()
    }
}

extension NewsListViewController: NewsListLocalDataProviderProtocol {
    func success(model: Any) {
        self.newsList = model as? [NewsModel]
    }
    
    func errorData(_ provide: GenericDataProvider?, error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

extension NewsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
    }
    
}

extension NewsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }

        guard let newsList else { return UITableViewCell() }
        cell.news = newsList[indexPath.row]

        return cell
    }
}
