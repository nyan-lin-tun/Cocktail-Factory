//
//  GlassTableViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class GlassTableViewController: UITableViewController {

    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Glass>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Glass>
    private var dataSource: DataSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Glass"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "glassCell")
        self.tableView.tableFooterView = UIView()
        self.setUpDataSource()
        self.getGlassData()
    }
    
    func getGlassData() {
        if LocalReachability.isConnectedToNetwork() {
            NetworkManager.shared().getGlass { (glassResponse, error) in
                if error == nil {
                    self.setGlassData(with: glassResponse?.drinks ?? [])
                }else {
                    //Display Error
                    print(error?.localizedDescription)
                }
            }
        }
    }
    
    private func setUpDataSource() {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView, cellProvider: { (tableView, indexPath, category) -> UITableViewCell? in
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "glassCell", for: indexPath)
            categoryCell.accessoryType = .disclosureIndicator
            categoryCell.textLabel?.text = category.strGlass
            return categoryCell
        })
    }

    private func setGlassData(with glass: [Glass]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(glass, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let drinkCollectionVC = GlassCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
        guard let drink = dataSource.itemIdentifier(for: indexPath) else {
          return
        }
        guard let glassName = drink.strGlass else {
          return
        }
        drinkCollectionVC.glassName = glassName
        self.navigationController?.pushViewController(drinkCollectionVC, animated: true)
    }
}
