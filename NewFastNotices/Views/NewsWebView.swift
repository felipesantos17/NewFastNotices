//
//  NewsWebView.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 20/11/23.
//

import WebKit

class NewsWebView: UIView {
    
    private var news: NewsModel? {
        didSet {
            loadingURL()
        }
    }
    
    lazy var newsWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.isHidden = true
        return webView
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .clear
        return containerView
    }()
    
    lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.center = center
        indicator.color = .primaryColor
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configBackgroud()
        configureView()
        setupConstraints()
    }
    
    func setNewsValue(_ news: NewsModel?) {
        guard let news else { return }
        self.news = news
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configBackgroud() {
        self.backgroundColor = .white
    }
    
    private func loadingURL() {
        guard let news, let url = URL(string: news.url) else { return }
        newsWebView.load(URLRequest(url: url))
    }
    
    private func configureView() {
        containerView.addSubview(loadingActivityIndicator)
        addSubview(containerView)
        addSubview(newsWebView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            newsWebView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            newsWebView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            newsWebView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            newsWebView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

extension NewsWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingActivityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingActivityIndicator.isHidden = true
        loadingActivityIndicator.stopAnimating()
        newsWebView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loadingActivityIndicator.isHidden = true
        loadingActivityIndicator.stopAnimating()
        newsWebView.isHidden = false
    }
}
