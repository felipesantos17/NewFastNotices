//
//  NewsViewController.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 06/11/23.
//

import UIKit

class NewsViewController: UIViewController {
    
    private var newsView: NewsView?
    private var news: NewsModel?
    
    override func loadView() {
        configView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func selectedNews(_ news: NewsModel?) {
        self.news = news
    }

    private func configView() {
        let newsView = NewsView()
        newsView.setNewsValue(self.news)
        self.view = newsView
    }
}
