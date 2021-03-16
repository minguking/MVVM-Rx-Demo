//
//  ArticleService.swift
//  MVVMRxDemo
//
//  Created by Kang Mingu on 2021/03/16.
//

import Foundation
import Alamofire
import RxSwift

protocol ArticleServiceProtocol {
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: ArticleServiceProtocol {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { observer -> Disposable in
            
            self.fetchNews { (error, articles) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let articles = articles {
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    
    
    private func fetchNews(completion: @escaping(Error?, [Article]?) -> Void) {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2021-02-16&sortBy=publishedAt&apiKey=7c66330b2a4749449ca47d28ba14f5ad"
        
        guard let url = URL(string: urlString) else { return completion(NSError(domain: "mingus",
                                                                                code: 403,
                                                                                userInfo: nil), nil)}
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .responseDecodable(of: ArticleResponse.self) { response in
                if let error = response.error {
                    return completion(error, nil)
                }
                
                if let articles = response.value?.articles {
                    return completion(nil, articles)
                }
            }
    }
}
