//
//  Article.swift
//  MVVMRxDemo
//
//  Created by Kang Mingu on 2021/03/16.
//

import UIKit

struct ArticleResponse: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
