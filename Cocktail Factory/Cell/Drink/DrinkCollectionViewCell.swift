//
//  DrinkCollectionViewCell.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 22/06/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import UIKit

class DrinkCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var drinkImageView: UIImageView!
    
    @IBOutlet weak var drinkTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.drinkTitle.textColor = .black
    }
    

}
