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
        label.textColor = .white
        label.text = "Fast News Now".uppercased()
        return label
    }()
    
    lazy var newsListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackGround()
        self.addCollectionView()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCollectionViewPotocol(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        newsListCollectionView.delegate = delegate
        newsListCollectionView.dataSource = dataSource
    }
    
    func updateCollectionView() {
        newsListCollectionView.reloadData()
    }
    
    private func configBackGround(){
        backgroundColor = .primaryColor
    }
    
    private func addCollectionView() {
        addSubview(newsListLabel)
        addSubview(newsListCollectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            self.newsListLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.newsListLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            self.newsListLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            self.newsListCollectionView.topAnchor.constraint(equalTo: self.newsListLabel.bottomAnchor, constant: 18),
            self.newsListCollectionView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.newsListCollectionView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.newsListCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }
}
