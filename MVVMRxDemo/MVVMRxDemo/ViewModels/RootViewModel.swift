//
//  RootViewModel.swift
//  MVVMRxDemo
//
//  Created by Kang Mingu on 2021/03/16.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "mingu news"
    
    private let articleService: ArticleServiceProtocol
    
    init(articleService: ArticleServiceProtocol) {
        self.articleService = articleService
    }
    
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        return articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
