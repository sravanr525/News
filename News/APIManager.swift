//
//  APIManager.swift
//  News
//
//  Created by Spurge on 06/02/21.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    private let apiKey = "44f6d78bdcdb4d389db1a2fd700deced"
    private let newsURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    func fetchData(completion: @escaping (String?, [Article]) -> (Void)){
        let url = URL(string: newsURL+apiKey)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error{
                completion(err.localizedDescription, [])
            }else if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                completion("Something went wrong", [])
            }else if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let news = try decoder.decode(NewsData.self, from: data)
                    completion(nil, news.getArticles())
                } catch let error{
                    completion(error.localizedDescription, [])
                }
            }else{
                completion("Something went wrong", [])
            }
        }
        task.resume()
    }
}
