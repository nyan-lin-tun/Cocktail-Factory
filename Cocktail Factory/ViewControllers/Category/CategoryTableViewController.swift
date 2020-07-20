//
//  CategoryTableViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Drink>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Drink>
    private var dataSource: DataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Category"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
        self.tableView.tableFooterView = UIView()
        self.setUpDataSource()
        self.getCategoryData()   
    }
    
    func getCategoryData() {
        if LocalReachability.isConnectedToNetwork() {
            self.displayLoading(onView: self.view)
            NetworkManager.shared().getCategory(result: self.handleCategoryResponse(response:error:))
        }else {
            
        }
    }
    
    private func handleCategoryResponse(response: CategoryResponse?, error: Error?) {
        self.hideLoading()
        if error == nil {
            self.setCategoryData(with: response?.drinks ?? [])
        }else {
            //Display Error
            
        }
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, category) -> UITableViewCell? in
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
            categoryCell.accessoryType = .disclosureIndicator
            categoryCell.textLabel?.text = category.strCategory
            return categoryCell
        })
    }

    private func setCategoryData(with category: [Drink]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(category, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let drinkCollectionVC = DrinkCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
        guard let drink = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        guard let categoryType = drink.strCategory else {
          return
        }
        drinkCollectionVC.categoryType = categoryType
        self.navigationController?.pushViewController(drinkCollectionVC, animated: true)
    }
    
}
