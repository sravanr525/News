//
//  ArticleViewModel.swift
//  News
//
//  Created by Spurge on 06/02/21.
//

import Foundation


class ArticleViewModel: NSObject {
    private(set) var newArticles = [Article]() {
        didSet {
            self.fetchNewsAriclesData()
        }
    }
    
    private(set) var error = String() {
        didSet {
            self.fetchNewsAriclesError()
        }
    }
    var fetchNewsAriclesData : (() -> ()) = {}
    var fetchNewsAriclesError : (() -> ()) = {}
    var startLoading : (() -> ()) = {}
    var StopLoading : (() -> ()) = {}

    override init() {
        super.init()
        getData()
    }
    
    func getData() {
        startLoading()
        APIManager.shared.fetchData(completion: { (err, articles) -> (Void) in
            self.StopLoading()
            if let error = err{
                self.error = error
                self.newArticles = []
            }else{
                self.newArticles = articles
                for article in self.newArticles{
                    if let url = article.getImagePURL() {
                        ImageCache.downloadImage(url: url, name: article.getImageFileName()) { (_) in }
                    }

                }
            }
        })
    }

}
