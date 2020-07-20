//
//  IngredientsCollectionViewCell.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 20/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var instructionsText: UILabel!
    
    @IBOutlet weak var ingredientsText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setDrinkDescription(data: Cocktail) {
        self.instructionsText.text = data.strInstructions

        var ingredients = ""
        
        let ingredientList = self.setUpIngredients(data: data)
        let measurementList = self.setUpMeasure(data: data)
        for (index, ingredient) in ingredientList.enumerated() {
            if ingredientList.count == measurementList?.count {
                ingredients = ingredients + "\(ingredient) - \(measurementList?[index] ?? "")\n"
            }else {
                ingredients = ingredients + "\(ingredient)\n"
            }
            
        }
        self.ingredientsText.text = ingredients
    }
    
    private func setUpIngredients(data: Cocktail) -> [String] {
        var ingredients: [String] = []
        let tempIngredient = [data.strIngredient1,
                              data.strIngredient2,
                              data.strIngredient3,
                              data.strIngredient4,
                              data.strIngredient5,
                              data.strIngredient6,
                              data.strIngredient7,
                              data.strIngredient8,
                              data.strIngredient9,
                              data.strIngredient10,
                              data.strIngredient11,
                              data.strIngredient12,
                              data.strIngredient13,
                              data.strIngredient14,
                              data.strIngredient15]
        for integrident in tempIngredient {
            if !(integrident?.isEmpty ?? true) {
                ingredients.append(integrident ?? "")
            }
        }
        return ingredients
    }
    
    
    private func setUpMeasure(data: Cocktail) -> [String]? {
        var strMeasure: [String] = []
        let tempMeasure = [data.strMeasure1,
                           data.strMeasure2,
                           data.strMeasure3,
                           data.strMeasure4,
                           data.strMeasure5,
                           data.strMeasure6,
                           data.strMeasure7,
                           data.strMeasure8,
                           data.strMeasure9,
                           data.strMeasure10,
                           data.strMeasure11,
                           data.strMeasure12,
                           data.strMeasure13,
                           data.strMeasure14,
                           data.strMeasure15]
        for measure in tempMeasure {
            if !(measure?.isEmpty ?? true) {
                strMeasure.append(measure ?? "")
            }
        }
        return strMeasure
    }
}

