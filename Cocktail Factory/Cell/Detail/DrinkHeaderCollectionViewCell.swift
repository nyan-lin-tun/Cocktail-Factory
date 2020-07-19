//
//  DrinkHeaderCollectionViewCell.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class DrinkHeaderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var drinkImage: UIImageView!
    
    @IBOutlet weak var drinkName: UILabel!
    
    @IBOutlet weak var drinkType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.drinkName.textColor = UIColor.black
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setDrinkHeaderData(data: Cocktail) {
        self.drinkName.text = data.strDrink
        self.drinkType.text = "-\(data.strCategory ?? "")\n-\(data.strAlcoholic ?? "")\n-\(data.strGlass ?? "")"
    }

}
