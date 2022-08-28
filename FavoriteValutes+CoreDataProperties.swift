//
//  FavoriteValutes+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 26.08.2022.
//
//

import Foundation
import CoreData


extension FavoriteValutes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteValutes> {
        return NSFetchRequest<FavoriteValutes>(entityName: "FavoriteValutes")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var charCode: String?

}

extension FavoriteValutes : Identifiable {

}
