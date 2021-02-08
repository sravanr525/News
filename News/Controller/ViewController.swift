//
//  ViewController.swift
//  News
//
//  Created by Spurge on 06/02/21.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var vwLoad: UIView!
    
    private var articleViewModel : ArticleViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        articleViewModel =  ArticleViewModel()
        articleViewModel.fetchNewsAriclesData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        articleViewModel.fetchNewsAriclesError = {
            DispatchQueue.main.async {
                self.normalAlert(title: "Error", subTitle: self.articleViewModel.error)
            }
        }
        articleViewModel.startLoading = {
            DispatchQueue.main.async {
                self.vwLoad.alpha = 1.0
            }
        }
        
        articleViewModel.StopLoading = {
            DispatchQueue.main.async {
                self.vwLoad.alpha = 0.0
            }
        }
    }
}
extension ViewController: UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleViewModel.newArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self)) as! ArticleTableViewCell
        let data = articleViewModel.newArticles[indexPath.row]
        cell.img.layer.cornerRadius = 10.0
        cell.img.layer.masksToBounds = true
        cell.lblTitle.text = data.getTitle()
        cell.lblSubTitle.text = data.getDescription()
        if ImageCache.imageFileExists(name: data.getImageFileName()) {
            let url = ImageCache.getImagePath(name: data.getImageFileName())
            cell.img.kf.setImage(with: url, placeholder: UIImage(named: "default_icon.jpg")!)
        }else if let url = URL(string: data.getUrlToImage()) {
            cell.img.kf.setImage(with: url, placeholder: UIImage(named: "default_icon.jpg")!)
        }else{
            cell.img.image = UIImage(named: "default_icon.jpg")
        }
        return cell
    }
}
