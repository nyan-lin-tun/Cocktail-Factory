//
//  HomeCollectionViewController.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit
import CoreData

class HomeCollectionViewController: UICollectionViewController, NSFetchedResultsControllerDelegate {

    var dataController:DataController!
    
    var cocktail: RandomCocktail?
    
    var fetchedResultsController: NSFetchedResultsController<RandomCocktail>!
    
    fileprivate func registerCells() {
        self.collectionView.register(cellType: HomeHeaderCollectionViewCell.self)
        self.collectionView.register(cellType: HomeTitleCollectionViewCell.self)
        self.collectionView.register(cellType: HomeDrinkCollectionViewCell.self)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        registerCells()
        self.setUpFetchedResult()
        if self.cocktail == nil {
            self.getRandomCocktail()
        }else {
            self.collectionView.reloadData()
        }
    }
    
    private func refreshRandomCocktail(sender: UIBarButtonItem) {
        self.getRandomCocktail()
    }
    
    private func setUpFetchedResult() {
        let fetchRequest:NSFetchRequest<RandomCocktail> = RandomCocktail.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let result = try? dataController.viewContext.fetch(fetchRequest) {
            self.cocktail = result.first
        }
    }
    
    private func getRandomCocktail() {
        if LocalReachability.isConnectedToNetwork() {
            self.displayLoading(onView: self.view)
            NetworkManager.shared().getRandomCocktail(result: self.randomCocktailResponseHandler(drinkResponse:error:))
        }else {
            
        }
    }
    
    private func saveRandomCocktail(imageData: Data?, cocktail: Cocktail?, randomCocktail: RandomCocktail) {
        
        randomCocktail.drinkId = cocktail?.idDrink
        randomCocktail.name = cocktail?.strDrink
        randomCocktail.image = imageData
        randomCocktail.drinkType = "\(cocktail?.strCategory ?? "") | \(cocktail?.strAlcoholic ?? "") | \(cocktail?.strGlass ?? "")"
        try? dataController.viewContext.save()
        self.setUpFetchedResult()
        self.hideLoading()
        self.collectionView.reloadData()
    }
    
    
    private func deleteRandomCocktail() {
        let randomCocktails = fetchedResultsController.fetchedObjects ?? []
        for rdmCocktail in randomCocktails {
            let indexPath = fetchedResultsController.indexPath(forObject: rdmCocktail)!
            let cocktailToDelete = fetchedResultsController.object(at: indexPath)
            dataController.viewContext.delete(cocktailToDelete)
            try? dataController.viewContext.save()
        }
    }
    
    private func randomCocktailResponseHandler(drinkResponse: RandomCocktailResponse?, error: Error?) {
        if error == nil {
            let randomCocktail = RandomCocktail(context: dataController.viewContext)
            let cocktailObject = drinkResponse?.drinks?[0]
            
            GenericNetwork.shared().getPhotoData(imageUrl: (cocktailObject?.strDrinkThumb!)!) { (data, error) in
                if error == nil {
                    self.deleteRandomCocktail()
                    self.saveRandomCocktail(imageData: data, cocktail: cocktailObject, randomCocktail: randomCocktail)
                }else {
                    //Error while getting photo image
                }
            }
        }else {
            self.hideLoading()
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
            guard let cocktail = self.cocktail else { return }
            drinkDetailViewController.idDrink = cocktail.drinkId ?? ""
            self.present(navigationController, animated: true, completion: nil)
        }else if indexPath.section == 2 {
            let alcoholListViewController = AlcoholTypeCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout.init())
            let drinkType = ["Alcoholic", "Non_alcoholic", "Optional_alcohol" ]
            alcoholListViewController.alcoholType = drinkType[indexPath.row]
            self.navigationController?.pushViewController(alcoholListViewController, animated: true)
            
        }
    }


}

extension HomeCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width - 20, height: 240)
        }else{
            return CGSize(width: collectionView.frame.width - 20, height: 50)
        }
    }
}
