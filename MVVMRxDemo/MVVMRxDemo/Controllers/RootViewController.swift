//
//  RootViewController.swift
//  MVVMRxDemo
//
//  Created by Kang Mingu on 2021/03/16.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController: UIViewController {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObservable: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    private lazy var collectionView: UICollectionView = {
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.delegate = self
        cv.dataSource = self
        
        return cv
    }()
    
    
    // MARK: - Lifecycle
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchArticles()
        configureCollectionView()
        subscribe()
    }
    
    
    // MARK: - API
    
    func fetchArticles() {
        viewModel.fetchArticles().subscribe { articleViewModel in
            self.articleViewModel.accept(articleViewModel)
        }.disposed(by: disposeBag)

    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        self.title = viewModel.title
    }
    
    func configureCollectionView() {
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func subscribe() {
        self.articleViewModelObservable.subscribe { articles in
            // collectionView to be reload
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }.disposed(by: disposeBag)

    }

}


extension RootViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell
        
        cell.imageView.image = nil
        
        let articleViewModel = self.articleViewModel.value[indexPath.item]
        cell.viewModel.onNext(articleViewModel)
        
        return cell
    }
    
}

extension RootViewController: UICollectionViewDelegate {
    
}

extension RootViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
