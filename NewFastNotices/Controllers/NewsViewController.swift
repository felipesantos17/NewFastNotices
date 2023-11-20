//
//  NewsViewController.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 06/11/23.
//

import WebKit

class NewsViewController: UIViewController {
    
    private var news: NewsModel? {
        didSet {
            self.title = news?.source.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func selectedNews(_ news: NewsModel?) {
        self.news = news
    }
    
    func openNews(readView: Bool) {
        readView ? configToReadView() : configWebView()
    }

    private func configToReadView() {
        let newsView = NewsView()
        newsView.setNewsValue(news)
        self.view = newsView
    }
    
    private func configWebView() {
        let webView = NewsWebView()
        webView.setNewsValue(news)
        self.view = webView
    }
}
