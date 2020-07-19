//
//  HomeCollectionViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {

    var cocktail: Cocktail?
    
    fileprivate func registerCells() {
        self.collectionView.register(cellType: HomeHeaderCollectionViewCell.self)
        self.collectionView.register(cellType: HomeTitleCollectionViewCell.self)
        self.collectionView.register(cellType: HomeDrinkCollectionViewCell.self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        self.getRandomCocktail()
        
    }
    
    private func getRandomCocktail() {
        if LocalReachability.isConnectedToNetwork() {
            NetworkManager.shared().getRandomCocktail(result: self.randomCocktailResponseHandler(drinkResponse:error:))
        }else {
            
        }
    }
    
    
    private func randomCocktailResponseHandler(drinkResponse: RandomCocktailResponse?, error: Error?) {
        if error == nil {
            self.cocktail = drinkResponse?.drinks?[0]
            self.collectionView.reloadData()
        }else {
            
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return 3
        }else {
            return 1
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let headerCell = collectionView.dequeueReusableCell(with: HomeHeaderCollectionViewCell.self, for: indexPath)
            headerCell.cocktailImage.image = UIImage(named: "glass")
            if let cocktail = self.cocktail {
                headerCell.setDrinkHeaderData(data: cocktail)
                if let imageUrl = cocktail.strDrinkThumb {
                    GenericNetwork.shared().getPhotoData(imageUrl: imageUrl) { (data, error) in
                        guard let data = data else {
                            return
                        }
                        let image = UIImage(data: data)
                        headerCell.cocktailImage.image = image
                        headerCell.setNeedsLayout()
                    }
                }
            }
            return headerCell
        }else if indexPath.section == 1{
            let titleCell = collectionView.dequeueReusableCell(with: HomeTitleCollectionViewCell.self, for: indexPath)
            return titleCell
        }else {
            let drinkTypeCell = collectionView.dequeueReusableCell(with: HomeDrinkCollectionViewCell.self, for: indexPath)
            let drinkType = ["Alcoholic 🥃", "Non alcoholic 🍹", "Optional alcohol 🍸" ]
            drinkTypeCell.drinkType.text = drinkType[indexPath.row]
            return drinkTypeCell
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let drinkDetailViewController = DrinkDetailCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
            let navigationController = UINavigationController(rootViewController: drinkDetailViewController)
            drinkDetailViewController.idDrink = self.cocktail?.idDrink ?? ""
            self.present(navigationController, animated: true, completion: nil)
        }else if indexPath.section == 2 {
            
        }
    }


}

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 20, height: 225)
        }else{
            return CGSize(width: collectionView.frame.width - 20, height: 50)
        }
        
        
        
    }
}
