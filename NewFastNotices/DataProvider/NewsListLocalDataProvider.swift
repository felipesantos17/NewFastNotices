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
        NewsListRepository.shared.getNewsList { newModelList, error in
            if let error {
                self.delegate?.errorData(self.delegate, error: error)
                return
            }
            
            if let newModelList {
                self.delegate?.success(model: newModelList)
            }
        }
    }
}
