//
//  UIViewController+Extension.swift
//  News
//
//  Created by Spurge on 06/02/21.
//

import UIKit


extension UIViewController{
    func normalAlert(title: String, subTitle: String){
        let alert = UIAlertController(title: title, message: subTitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
