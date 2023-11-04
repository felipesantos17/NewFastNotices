//
//  NewsCollectionViewCell.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "NewsTableViewCell"
    
    public var news: NewsModel? {
        didSet {
            self.nameLabel.text = news?.source.name
            self.authorLabel.text = news?.author
            self.titleLabel.text = news?.title
            self.descriptionLabel.text = news?.description
            self.newsImageView.loadImage(from: news?.urlToImage)
            self.newsDateLabel.text = news?.publishedAt.toString()
        }
    }
    
    lazy var newsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            newsTitleStackView,
            newsTitleAndDescriptionStackView,
            newsContentStackView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8
        return stack
    }()
    
    lazy var newsTitleStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            authorLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    
    lazy var newsTitleAndDescriptionStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel,
            descriptionLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColorFromRGB(rgbValue: 0x255CF5)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    lazy var newsContentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            newsImageView,
            newsDateAndLinkButtonStackView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var newsImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var newsDateAndLinkButtonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            newsDateLabel,
            newsLinkButton
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16
        return stack
    }()
    
    lazy var newsDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    lazy var newsLinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "link.badge.plus"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(openLink), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func openLink() {
        guard let url = news?.url, let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
    
    private func configureView() {
        addSubview(newsStackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.newsStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            self.newsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            self.newsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            self.newsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            self.newsImageView.heightAnchor.constraint(equalToConstant: 240),
            
            self.newsLinkButton.widthAnchor.constraint(equalToConstant: 24),
            self.newsLinkButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
