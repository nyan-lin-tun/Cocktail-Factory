//
//  CellRegistrations+Extensions.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

extension UICollectionView {
    func register<T: UICollectionViewCell>(cellType: T.Type,
                                           bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type,
                                                      for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type,
                                      bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type,
                                                 for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {}




