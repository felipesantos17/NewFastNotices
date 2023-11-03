//
//  NewsListLocalDataProvider.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import Foundation

protocol NewsListLocalDataProviderProtocol: GenericDataProvider {}

class NewsListLocalDataProvider: DataProviderManager<NewsListLocalDataProviderProtocol, NewsModel> {
    
    func getNewsList() {
        NewsListRepository.shared.getNewsList { response in
            DispatchQueue.main.async { [weak self] in
                switch response {
                case .success(let success):
                    self?.delegate?.success(model: success)
                case .failure(let failure):
                    self?.delegate?.errorData(self?.delegate, error: failure)
                }
            }
        }
    }
}
