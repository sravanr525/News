//
//  Article.swift
//  News
//
//  Created by Spurge on 06/02/21.
//

import Foundation

struct Article: Decodable {
    var source: Source?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?

    
    func getSource() -> Source{
        return source ?? Source(id: "", name: "")
    }
    
    func getAuthor() -> String{
        return author ?? ""
    }
    
    func getTitle() -> String{
        return title ?? ""
    }
    
    func getDescription() -> String{
        return description ?? ""
    }
    
    func getUrl() -> String{
        return url ?? ""
    }

    func getUrlToImage() -> String{
        return urlToImage ?? ""
    }

    func getPublishedAt() -> String{
        return publishedAt ?? ""
    }

    func getContent() -> String{
        return content ?? ""
    }

    func getImageFileName() -> String{
        return (title ?? "Image") + ".png"
    }

    func getImagePURL() -> URL?{
        if getUrlToImage() != ""{
            return URL(string: getUrlToImage())
        }
        return nil
    }
}

struct NewsData: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?

    func getArticles() -> [Article]{
        return articles ?? []
    }

}

struct Source: Decodable {
    var id: String?
    var name: String?
}
