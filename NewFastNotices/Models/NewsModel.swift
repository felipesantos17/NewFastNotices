//
//  NewsModel.swift
//  NewFastNotices
//
//  Created by Felipe Santos on 15/10/23.
//

import Foundation

struct NewsModelResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [NewsModel]?
}

struct NewsModel: Codable {
    var source: SourceModel
    var author: String?
    var title: String
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: Date
    var content: String?
}
