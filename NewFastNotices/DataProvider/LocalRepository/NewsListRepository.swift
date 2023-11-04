//
//  NewsListRepository.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import Foundation

enum NewsListError: Error {
    case invalidData
    case invalidResponse
    case message(_ error: Error?)
}

class NewsListRepository {
    
    static var shared: NewsListRepository = NewsListRepository()
    
    private init() {}
    
    func getNewsList(completion: @escaping (Result<[NewsModel], NewsListError>) -> Void) {
        let sendURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9be0b53f949d4de7b4e968e0a36e65e5"
        
        let url = URL(string: sendURL)
        guard let url else { print("error URL"); return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let httpURLResponse = response as? HTTPURLResponse, 200 ... 299  ~= httpURLResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let articles = try decoder.decode(NewsModelResponse.self, from: data)
                guard let newsModelList = articles.articles else { return }
                completion(.success(newsModelList))
            } catch {
                completion(.failure(.message(error)))
            }
            
        }.resume()
    }
}


