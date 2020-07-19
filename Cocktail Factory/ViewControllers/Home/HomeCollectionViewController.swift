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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(cellType: HomeHeaderCollectionViewCell.self)
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    }

    // MARK: UICollectionViewDelegate


}

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 225)
    }
}
