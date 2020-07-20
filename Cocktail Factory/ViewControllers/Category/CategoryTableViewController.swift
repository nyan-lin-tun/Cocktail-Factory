//
//  CategoryTableViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var dataController:DataController!
    
    var categoryList: [CategoryList]?
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, CategoryList>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CategoryList>
    private var dataSource: DataSource!
    
    
    fileprivate func setUpTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "categoryCell")
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Category"
        self.setUpTableView()
        self.setUpDataSource()
        self.setUpFetchedResult()
        if self.categoryList?.count == 0 {
            self.getCategoryData()
        }else {
            self.setCategoryData(with: self.categoryList!, animated: false)
        }
    }
    
    private func setUpFetchedResult() {
        let fetchRequest:NSFetchRequest<CategoryList> = CategoryList.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            self.categoryList = result
        }
    }
    
    func getCategoryData(displayLoading: Bool = true) {
        if LocalReachability.isConnectedToNetwork() {
            if displayLoading {
                self.displayLoading(onView: self.view)
            }
            NetworkManager.shared().getCategory(result: self.handleCategoryResponse(response:error:))
        }else {
            self.displayNetworkAlert()
        }
    }
    
    private func handleCategoryResponse(response: CategoryResponse?, error: Error?) {
        self.hideLoading()
        if error == nil {
            for i in response?.drinks ?? [] {
                let category = CategoryList(context: dataController.viewContext)
                category.name = i.strCategory
                try? dataController.viewContext.save()
            }
            self.setUpFetchedResult()
            self.setCategoryData(with: self.categoryList!)
        }else {
            self.displayAlert(title: "Error while trying to get category data.", message: nil)
        }
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, category) -> UITableViewCell? in
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
            categoryCell.accessoryType = .disclosureIndicator
            categoryCell.textLabel?.text = category.name
            return categoryCell
        })
    }

    private func setCategoryData(with category: [CategoryList], animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(category, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let drinkCollectionVC = DrinkCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
        guard let drink = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        guard let categoryType = drink.name else {
          return
        }
        drinkCollectionVC.categoryType = categoryType
        if LocalReachability.isConnectedToNetwork() {
            self.navigationController?.pushViewController(drinkCollectionVC, animated: true)
        }else {
            self.displayNetworkAlert()
        }
        
    }
    
}
