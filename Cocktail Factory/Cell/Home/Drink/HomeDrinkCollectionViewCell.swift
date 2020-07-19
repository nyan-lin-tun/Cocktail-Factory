//
//  HomeDrinkCollectionViewCell.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 19/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class HomeDrinkCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var roundBackgroundView: UIView!
    
    @IBOutlet weak var drinkType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.roundBackgroundView.layer.cornerRadius = 10
        
    }

}
