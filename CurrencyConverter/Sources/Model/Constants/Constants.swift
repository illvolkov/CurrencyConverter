//
//  Constants.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 01.09.2022.
//

import UIKit

enum Strings {
    
    //MARK: - AppDelegate
    static let persistentContainerName: String = "CurrencyConverter"
    
    //MARK: - FavoriteValutes+CoreDataProperties
    static let favoriteValutesEntityName: String = "FavoriteValutes"
    
    //MARK: - TabBarController
    static let exchangeRatesTabItemTitle: String = "Курсы валют"
    static let calculatorTabItemTitle: String = "Калькулятор"
    
    //MARK: - CalculatorController
    static let zeroTitle: String = "0"
    static let oneTitle: String = "1"
    static let twoTitle: String = "2"
    static let threeTitle: String = "3"
    static let fourTitle: String = "4"
    static let fiveTitle: String = "5"
    static let sixTitle: String = "6"
    static let sevenTitle: String = "7"
    static let eightTitle: String = "8"
    static let nineTitle: String = "9"
    static let eraseAllTitle : String = "C"
    static let swapTitle: String = "⇅"
    static let divisionTitle: String = "/"
    static let multiplicationTitle: String = "X"
    static let substractTitle: String = "-"
    static let foldTitle: String = "+"
    static let equalTitle: String = "="
    static let selectValuteTitle: String = "Выберете валюту"
    
    //MARK: - CurrenciesController
    static let valuteElementName: String = "Valute"
    static let valuteNameParameter: String = "Name"
    static let valuteCharCodeParameter: String = "CharCode"
    static let valuteValueParameter: String = "Value"
    
    //MARK: - CurrenciesTableViewCell
    static let currenciesCellIdentifier: String = "CurrenciesTableViewCell"
}

enum Offsets {
    //MARK: - CalculatorController
    static let outputValuteViewBottomOffset: CGFloat = 1
    static let leftOffset10: CGFloat = 10
    static let rightOffset_10: CGFloat = -10
    
    //MARK: - CurrenciesController
    static let segmentedControlTopOffset: CGFloat = 30
    static let tableViewTopOffset: CGFloat = 10
    
    //MARK: - CurrenciesTableViewCell
    static let centerYLeftOffset15: CGFloat = 15
    static let centerYRightOffset_15: CGFloat = -15
    static let contentViewOffset10: CGFloat = 10
}

enum Sizes {
    //MARK: - CalculatorController
    static let labelFontSize0_13: CGFloat = 0.13
    static let fontSize0_07: CGFloat = 0.07
    static let inputValuteViewHeightSize: CGFloat = 0.3
    static let inputLabelWidthSize: CGFloat = 0.6
    static let zeroButtonWidthSize: CGFloat = 0.75
    static let widthSize0_375: CGFloat = 0.375
    
    //MARK: - CurrenciesTableViewCell
    static let fontSize0_045: CGFloat = 0.045
    static let nameLabelWidthSize: CGFloat = 0.8
    static let favoritesButtonWidthSize: CGFloat = 0.1
    static let contentViewHeightSize: CGFloat = 0.25
    static let contentViewCornerRadius: CGFloat = 0.05
}

enum ButtonTags {
    //MARK: - CalculatorController
    static let zeroButtonTag: Int = 0
    static let oneButtonTag: Int = 1
    static let twoButtonTag: Int = 2
    static let threeButtonTag: Int = 3
    static let fourButtonTag: Int = 4
    static let fiveButtonTag: Int = 5
    static let sixButtonTag: Int = 6
    static let sevenButtonTag: Int = 7
    static let eightButtonTag: Int = 8
    static let nineButtonTag: Int = 9
    static let eraseAllButtonTag: Int = 10
    static let swapButtonTag: Int = 11
    static let divisionButtonTag: Int = 12
    static let multiplicationButtonTag: Int = 13
    static let substractButtonTag: Int = 14
    static let foldButtonTag: Int = 15
    static let equalButtonTag: Int = 16
}

enum Sequences {
    //MARK: - CurrenciesController
    static let segments: [String] = ["Все", "Избранное"]
}

enum Images {
    //MARK: - TabBarController
    static let exchangeRatesTabItemImage: String = "dollarsign.circle"
    static let calculatorTabItemImage: String = "equal.circle"
    
    //MARK: - CurrenciesTableViewCell
    static let favoritesButtonImage: String = "heart"
    static let favoritesButtonFillImage: String = "heart.fill"
}
