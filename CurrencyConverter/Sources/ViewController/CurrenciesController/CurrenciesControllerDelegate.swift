//
//  CurrenciesControllerDelegate.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 29.08.2022.
//

protocol CurrenciesControllerDelegate: AnyObject {
    var isFavoriteSelected: Bool { get set }
    var isInputFavoriteSelected: Bool { get set }
    var isOutputFavoriteSelected: Bool { get set }
    var inputValuteSelected: Valute? { get set }
    var outputValuteSelected: Valute? { get set }
    var inputFavoriteValuteSelected: FavoriteValutes? { get set }
    var outputFavoriteValuteSelected: FavoriteValutes? { get set }
    func setupInputValute()
    func setupOutputValute()
}
