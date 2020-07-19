//
//  DrinkDetailCollectionViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class DrinkDetailCollectionViewController: UICollectionViewController {
    
    var idDrink:String = ""
    var drink: Cocktail?
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.collectionView.register(cellType: DrinkHeaderCollectionViewCell.self)
        self.getDrinkDetail()
    }

    private func getDrinkDetail() {
        if LocalReachability.isConnectedToNetwork() {
            self.displayLoading(onView: self.view)
            NetworkManager.shared().getIngredient(idDrink: self.idDrink,
                                                  result: self.drinkDetailResponseHandler(drinkResponse:error:))
        }else {
            
        }
    }
    
    
    private func drinkDetailResponseHandler(drinkResponse: RandomCocktailResponse?, error: Error?) {
        self.hideLoading()
        if error == nil {
            self.drink = drinkResponse?.drinks?[0]
            self.collectionView.reloadData()
        }else {
            
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let drinkHeaderCell = collectionView.dequeueReusableCell(with: DrinkHeaderCollectionViewCell.self, for: indexPath)
        
        drinkHeaderCell.drinkImage.image = UIImage(named: "glass")
        if let drink = self.drink {
            drinkHeaderCell.setDrinkHeaderData(data: drink)
            if let imageUrl = drink.strDrinkThumb {
                GenericNetwork.shared().getPhotoData(imageUrl: imageUrl) { (data, error) in
                    guard let data = data else {
                        return
                    }
                    let image = UIImage(data: data)
                    drinkHeaderCell.drinkImage.image = image
                    drinkHeaderCell.setNeedsLayout()
                }
            }
        }
        
        return drinkHeaderCell
    }
}

extension DrinkDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + flowLayout.minimumInteritemSpacing
        let size = Int((collectionView.bounds.width - totalSpace))
        return CGSize(width: size, height: 140)
    }
}
