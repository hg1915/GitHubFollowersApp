//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by GGTECH LLC on 11/17/21.
//

import UIKit

extension UIViewController {
   func presentGFAlertOnMainThread(title:String, message: String, buttonTitle: String){
        
       DispatchQueue.main.async {
           let alertView = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
           alertView.modalPresentationStyle = .overFullScreen
           alertView.modalTransitionStyle = .crossDissolve
           self.present(alertView, animated: true)
       }
    }
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
