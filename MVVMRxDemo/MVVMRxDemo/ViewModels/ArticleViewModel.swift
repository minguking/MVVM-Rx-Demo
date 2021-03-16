//
//  ArticleViewModel.swift
//  MVVMRxDemo
//
//  Created by Kang Mingu on 2021/03/16.
//

import Foundation

struct ArticleViewModel {
    private let article: Article
    
    var iamgeURL: String? {
        return article.urlToImage
    }
    
    var title: String? {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    init(article: Article) {
        self.article = article
    }
    
}
