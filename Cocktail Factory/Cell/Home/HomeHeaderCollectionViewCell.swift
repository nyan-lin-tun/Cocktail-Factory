//
//  HomeHeaderCollectionViewCell.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class HomeHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cocktailImage: UIImageView!
    
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var cocktailName: UILabel!
    
    @IBOutlet weak var cocktailType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.roundCorner()
    }
    
    private func roundCorner() {
        self.cardView.layer.cornerRadius = 10
        self.cocktailImage.clipsToBounds = true
        self.cocktailImage.layer.cornerRadius = 10
    }
    
    func setDrinkHeaderData(data: Cocktail) {
        self.cocktailName.text = data.strDrink
        self.cocktailType.text = "\(data.strCategory ?? "") | \(data.strAlcoholic ?? "") | \(data.strGlass ?? "")"
    }

}
