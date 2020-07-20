//
//  GlassCollectionViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class GlassCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var glassName: String = ""
    
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
        self.title = glassName
        self.collectionView.register(cellType: DrinkCollectionViewCell.self)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 10
        }
        self.setUpDataSource()
        self.getGlassDrinks()

    }


    func getGlassDrinks() {
        if LocalReachability.isConnectedToNetwork() {
            self.displayLoading(onView: self.view)
            NetworkManager.shared().getGlassByFilter(glassName: self.glassName,
                                                     result: self.handleGlassDrinksResponse(response:error:))
        }else {
            
        }
    }
    
    private func handleGlassDrinksResponse(response: CategoryFilterResponse?, error: Error?) {
        self.hideLoading()
        if error == nil {
            self.setGlassFilterData(with: response?.drinks ?? [])
        }else {
            //Display Error
            
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
    
    private func setGlassFilterData(with categoryFilterDrink: [CategoryFilterDrink]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(categoryFilterDrink, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width - 20, height: 100)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let drinkDetailViewController = DrinkDetailCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
        let navigationController = UINavigationController(rootViewController: drinkDetailViewController)
        drinkDetailViewController.idDrink = dataSource.itemIdentifier(for: indexPath)?.idDrink ?? ""
        self.present(navigationController, animated: true, completion: nil)
    }

}
