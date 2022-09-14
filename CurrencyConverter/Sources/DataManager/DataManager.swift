//
//  DataManager.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 25.08.2022.
//

import UIKit

class DataManager {

    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

    var favoriteValutes = [FavoriteValutes]()

    func getFavoriteValutes(completion: () -> Void) {
        guard let context = context else { return }

        do {
            favoriteValutes = try context.fetch(FavoriteValutes.fetchRequest())
            completion()
        }
        catch {
            print(error)
            return
        }
    }

    func save(valute: Valute) {
        guard let context = context else { return }
        
        let favoriteValutes = FavoriteValutes(context: context)
        favoriteValutes.name = valute.name
        favoriteValutes.charCode = valute.charCode
        favoriteValutes.value = valute.value
        favoriteValutes.isFavorite = valute.isFavorite

        do {
            try context.save()
            getFavoriteValutes {
                print("Валюта сохранилась")
            }
        }
        catch {
            print(error)
            return
        }
    }

    func delete(favoriteValute: FavoriteValutes) {
        guard let context = context else { return }

        context.delete(favoriteValute)

        do {
            try context.save()
            getFavoriteValutes {
                print("Валюта удалилась")
            }
        }
        catch {
            print(error)
            return
        }
    }
}
