//
//  GlassTableViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit
import CoreData

class GlassTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var dataController:DataController!
    
    var glassList: [GlassList]?
    
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, GlassList>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, GlassList>
    private var dataSource: DataSource!
    
    
    fileprivate func setUpTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "glassCell")
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Glass"
        self.setUpTableView()
        self.setUpDataSource()
        self.setUpFetchedResult()
        if self.glassList?.count == 0 {
            self.getGlassData()
        }else {
            self.setGlassData(with: self.glassList!, animated: false)
        }
        
    }
    
    private func setUpFetchedResult() {
        let fetchRequest:NSFetchRequest<GlassList> = GlassList.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            self.glassList = result
        }
    }
    
    func getGlassData() {
        if LocalReachability.isConnectedToNetwork() {
            self.displayLoading(onView: self.view)
            NetworkManager.shared().getGlass(result: self.handleGlassResponse(response:error:))
        }else {
            self.displayNetworkAlert()
        }
    }
    
    private func handleGlassResponse(response: GlassResponse?, error: Error?) {
        self.hideLoading()
        if error == nil {
            for i in response?.drinks ?? [] {
                let glass = GlassList(context: dataController.viewContext)
                glass.name = i.strGlass
                try? dataController.viewContext.save()
            }
            self.setUpFetchedResult()
            self.setGlassData(with: self.glassList!)

        }else {
            self.displayAlert(title: "Error while trying get glass data.", message: nil)
        }
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, category) -> UITableViewCell? in
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "glassCell", for: indexPath)
            categoryCell.accessoryType = .disclosureIndicator
            categoryCell.textLabel?.text = category.name
            return categoryCell
        })
    }

    private func setGlassData(with glass: [GlassList], animated: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(glass, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let drinkCollectionVC = GlassCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
        guard let drink = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        guard let glassName = drink.name else {
          return
        }
        drinkCollectionVC.glassName = glassName
        if LocalReachability.isConnectedToNetwork() {
            self.navigationController?.pushViewController(drinkCollectionVC, animated: true)
        }else {
            self.displayNetworkAlert()
        }
        
    }
}


    
   

