//
//  NewsListRepository.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import Foundation

enum NewsListError: Error {
    case fileNotFound
}

class NewsListRepository {
    
    static var shared: NewsListRepository = NewsListRepository()
    
    private init() {}
    
    func getNewsList(completion: ([NewsModel]?, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "NewList", ofType: "json") {
            do {
                let url = URL(filePath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let newsModelList = try decoder.decode([NewsModel].self, from: data)
                completion(newsModelList, nil)
            } catch {
                print("\(error)")
                completion(nil, error)
            }
        } else {
            completion(nil, NewsListError.fileNotFound)
        }
        
    }
}

extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
