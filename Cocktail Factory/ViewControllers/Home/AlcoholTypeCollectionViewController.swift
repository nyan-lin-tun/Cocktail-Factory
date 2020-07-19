//
//  AlcoholTypeCollectionViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit


class AlcoholTypeCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    
    var alcoholType: String = ""
      
    enum Section {
        case main
    }
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, CategoryFilterDrink>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CategoryFilterDrink>
    private var dataSource: DataSource!
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.title = alcoholType
        self.collectionView.register(cellType: DrinkCollectionViewCell.self)
        self.setUpDataSource()
        self.getAlcolholByType()
        
    }

    
    func getAlcolholByType() {
        if LocalReachability.isConnectedToNetwork() {
            NetworkManager.shared().filterAlcoholByType(type: self.alcoholType,
                                                        result: self.handleFilterAlcoholResponse(response:error:))
        }else {
            
        }
    }
    
    private func handleFilterAlcoholResponse(response: CategoryFilterResponse?, error: Error?) {
        if error == nil {
            print("-----------------")
            print(response?.drinks?.count)
            self.setFilterByAlcoholData(with: response?.drinks ?? [])
        }else {
            
        }
    }
    
    private func setUpDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: self.collectionView, cellProvider: { (collectionView, indexPath, drink) -> UICollectionViewCell? in
            let drinkCell = collectionView.dequeueReusableCell(with: DrinkCollectionViewCell.self, for: indexPath)
            drinkCell.drinkTitle.text = drink.strDrink
            drinkCell.drinkImageView.image = UIImage(named: "glass")
            if let imageUrl = drink.strDrinkThumb {
                GenericNetwork.shared().getPhotoData(imageUrl: imageUrl) { (data, error) in
                    guard let data = data else {
                        return
                    }
                    let image = UIImage(data: data)
                    drinkCell.drinkImageView.image = image
                    drinkCell.setNeedsLayout()
                }
            }
            return drinkCell
        })
    }
    
    private func setFilterByAlcoholData(with categoryFilterDrink: [CategoryFilterDrink]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoryFilterDrink, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width - 20, height: 100)
    }
    
}
