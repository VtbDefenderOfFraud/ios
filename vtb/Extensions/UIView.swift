//
//  UIView.swift
//  vtb
//
//  Created by Alina Golubeva on 14.05.2021.
//

import UIKit
import SDWebImage

extension UIView {
    static let activityTag = 1005
    
    func showActivity() {
        let container = UIView()
        container.backgroundColor = .white
        container.tag = Self.activityTag
        
        self.addSubview(container)
        container.snp.makeConstraints {
            $0.size.equalToSuperview()
        }
        
        let activityView = UIActivityIndicatorView(style: .gray)
        container.addSubview(activityView)
        activityView.startAnimating()
        
        activityView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func hideActivity() {
        self.viewInSubviews(tag: Self.activityTag)?.removeFromSuperview()
    }
    
    func viewInSubviews(tag: Int) -> UIView? {
        for view in self.subviews where view.tag == tag {
            return view
        }
        
        return nil
    }
}

extension UIImageView {
    func set(url: String?) {
        guard let url = url else { return }
        
        self.sd_setImage(with: URL(string: url), completed: nil)
    }
}
