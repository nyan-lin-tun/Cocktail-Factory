//
//  UIViewController+Extensions.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

var loadingView : UIView?
 
extension UIViewController {
    
    func displayLoading(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(loadingView!)
        }
        
        loadingView = spinnerView
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
            loadingView = nil
        }
    }
}
