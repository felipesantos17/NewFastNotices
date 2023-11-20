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
    
    private func showAlertGoToNews(_ title: String?, _ indexPath: IndexPath) {
        let newsViewController = NewsViewController()
        newsViewController.selectedNews(newsList?[indexPath.row])
        
        let alert = UIAlertController(title: title, message: "O que deseja fazer com essa notícia?", preferredStyle: .alert)
        
        alert.addAction(.init(title: "Ler notícia!", style: .default, handler: { [weak self] _ in
            newsViewController.openNews(readView: true)
            self?.navigationController?.pushViewController(newsViewController, animated: true)
        }))
        alert.addAction(.init(title: "Abrir notícia!", style: .default, handler: { [weak self] _ in
            newsViewController.openNews(readView: false)
            self?.navigationController?.pushViewController(newsViewController, animated: true)
        }))
        
        self.present(alert, animated: true)
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
        showAlertGoToNews(newsList?[indexPath.row].source.name, indexPath)
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
