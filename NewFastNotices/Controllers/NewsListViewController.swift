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
            self.newsListView?.updateCollectionView()
        }
    }

    override func loadView() {
        self.newsListView = NewsListView()
        self.view = newsListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.newsListView?.configCollectionViewPotocol(delegate: self, dataSource: self)
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

extension NewsListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newsViewController = NewsViewController()
        newsViewController.selectedNews(newsList?[indexPath.row])
        self.navigationController?.pushViewController(newsViewController, animated: true)
    }
}

extension NewsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: NewsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell,
              let newsList else { return UICollectionViewCell() }
        
        cell.news = newsList[indexPath.row]
        
        return cell
        
    }
}
