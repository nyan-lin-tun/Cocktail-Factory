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
        self.collectionView.register(cellType: IngredientsCollectionViewCell.self)
        
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
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
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
        }else {
            let descriptionCell = collectionView.dequeueReusableCell(with: IngredientsCollectionViewCell.self, for: indexPath)
                if let drink = self.drink {
                    descriptionCell.setDrinkDescription(data: drink)
                }
            return descriptionCell
        }
        
    }
}

extension DrinkDetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSize(width: collectionView.bounds.width, height: 140)
        }else {
            guard let ingredientsCell: IngredientsCollectionViewCell = Bundle.main.loadNibNamed("IngredientsCollectionViewCell",
                                                                          owner: self,
                                                                          options: nil)?.first as? IngredientsCollectionViewCell else {
                return CGSize.zero
            }
            ingredientsCell.setNeedsLayout()
            ingredientsCell.layoutIfNeeded()
            return CGSize(width: collectionView.bounds.width, height: 500)
        }

    }
}
