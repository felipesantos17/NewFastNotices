//
//  NewsTableViewCell.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let identifier: String = "NewsTableViewCell"
    
    public var news: NewsModel? {
        didSet {
            self.nameLabel.text = news?.source.name
            self.authorLabel.text = news?.author
            self.titleLabel.text = news?.title
            self.descriptionLabel.text = news?.description
            self.newsImageView.loadImage()
            self.dateLabel.text = news?.publishedAt.toString()
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
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var newsContentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            newsImageView,
            newsDateAndLinkStackView
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
    
    lazy var newsDateAndLinkStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            dateLabel,
            newsLinkImageView
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
//        stack.alignment = .fill
//        stack.distribution = .equalSpacing
//        stack.spacing = 4
        return stack
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var newsLinkImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "link.badge.plus"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureView()
        self.setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        addSubview(newsStackView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.newsStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12),
            self.newsStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            self.newsStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            self.newsStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            self.newsImageView.heightAnchor.constraint(equalToConstant: 240),
            
            self.newsLinkImageView.widthAnchor.constraint(equalToConstant: 24),
            self.newsLinkImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}

extension UIImageView {
    
    func loadImage() {
        self.image = UIImage(named: "deafult-image.jpg")
    }
}

extension Date {
    
    func toString(with formatter: String = "dd/MM/yyyy") -> String? {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = formatter
        return dateFormat.string(from: self)
    }
}