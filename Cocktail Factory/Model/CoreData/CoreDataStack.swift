//
//  CoreDataStack.swift
//  Cocktail Factory
//
//  Created by Nyan Lin Tun on 20/07/2020.
//  Copyright © 2020 Nyan Lin Tun. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {

    class func saveToCoreData(dataController: DataController) {
        dataController.viewContext.performAndWait {
            if dataController.viewContext.hasChanges {
                do {
                    try dataController.viewContext.save()
                } catch {
                    
                }
            }
        }
    }
}

