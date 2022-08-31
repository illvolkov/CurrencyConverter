//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Ilya Volkov on 30.08.2022.
//

import XCTest

class CurrencyConverterUITests: XCTestCase {
    
    //Добавление валюты Австралийский доллар из списка валют в список избранных
    func testAddValuteToFavorite() {
        
        let app = XCUIApplication()
        app.launch()
        
        let favoriteButtonInRow = app.tables.cells.containing(.staticText, identifier:"Австралийский доллар").buttons["love"]
        let favoritesButton = app.buttons["Избранное"]
        let addedCell = app.tables.cells.containing(.staticText, identifier:"Австралийский доллар").children(matching: .other).element(boundBy: 1)
        
        favoriteButtonInRow.tap()
        favoritesButton.tap()
        XCTAssertTrue(addedCell.exists)
    }
    
    //Удаление валюты Австралийский доллар из списка валют
    func testDeleteFavoriteValute() {
        
        let app = XCUIApplication()
        app.launch()
        
        let deleteValute = app.tables.cells.containing(.staticText, identifier: "Австралийский доллар").buttons["love"]
        let favoritesButton = app.buttons["Избранное"]
        let deletedCell = app.tables.cells.containing(.staticText, identifier:"Австралийский доллар").children(matching: .other).element(boundBy: 1)
        
        deleteValute.tap()
        favoritesButton.tap()
        XCTAssertFalse(deletedCell.exists)
    }
    
    //Удаление валюты Австралийский доллар из списка избранных валют
    func testDeleteValuteFromFavorite() {
        
        let app = XCUIApplication()
        app.launch()
        
        let addValute = app.tables.cells.containing(.staticText, identifier: "Австралийский доллар").buttons["love"]
        let favoritesButton = app.buttons["Избранное"]
        let deleteValuteFromFavorite = app.tables.cells.containing(.staticText, identifier: "Австралийский доллар").buttons["love"]
        let deletingValute = app.tables.cells.containing(.staticText, identifier:"Австралийский доллар").children(matching: .other).element(boundBy: 1)
        
        addValute.tap()
        favoritesButton.tap()
        deleteValuteFromFavorite.tap()
        
        XCTAssertFalse(deletingValute.exists)
    }
    
    //Добавление валюты для ввода и вывода и расчет кросс-курса валют
    func testAddInputAndOutputValute() {
        
        let app = XCUIApplication()
        app.launch()
        
        //Добавление валют
        let calculatorTabItem = app.tabBars["Tab Bar"].buttons["Калькулятор"]
        let inputValuteView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element(boundBy: 0).staticTexts["0"]
        
        let selectedInputValute = app.tables.cells.containing(.staticText, identifier:"Австралийский доллар").children(matching: .other).element(boundBy: 0)
        
        let outputValuteView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["0"]
        
        let selectedOutputValute = app.tables.cells.containing(.staticText, identifier:"Азербайджанский манат").children(
            matching: .other).element(boundBy: 0)
        
        let inputValuteCharCode = app.staticTexts["AUD"]
        let outputValuteCharCode = app.staticTexts["AZN"]
        
        calculatorTabItem.tap()
        inputValuteView.tap()
        selectedInputValute.tap()
        outputValuteView.tap()
        selectedOutputValute.tap()
        
        XCTAssertTrue(inputValuteCharCode.exists)
        XCTAssertTrue(outputValuteCharCode.exists)
        
        //Ввод 50
        let fiveButton = app.buttons["5"]
        let zeroButton = app.buttons["0"]
        //Вывод 42.61341087676511
        let crossRate = app.staticTexts["42.61341087676511"]
        
        fiveButton.tap()
        zeroButton.tap()
        
        XCTAssertTrue(crossRate.exists)
        
        //Стереть значения input и output
        let eraseAllButton = app.staticTexts["C"]
        
//        let inputValue = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).staticTexts["0"]
//
//        let outputValue = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["0"]

        eraseAllButton.tap()
        
        XCTAssertTrue(inputValuteView.exists)
        XCTAssertTrue(outputValuteView.exists)
        
        //Поменять местами валюты
        let swapButton = app.staticTexts["⇅"]
        let swapCrossRate = app.staticTexts["58.66697709859036"]
        
        fiveButton.tap()
        zeroButton.tap()
        
        XCTAssertTrue(crossRate.exists)
        swapButton.tap()
        XCTAssertTrue(swapCrossRate.exists)
        swapButton.tap()
        XCTAssertTrue(crossRate.exists)
        
        //Арифметические операторы
        let divisionButton = app.buttons["/"]
        let multiplicationButton = app.buttons["X"]
        let subtractButton = app.buttons["-"]
        let foldButton = app.buttons["+"]
        let twoButton = app.buttons["2"]
        let equalButton = app.buttons["="]
        
        let inputValuteViewAfterDivision = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element(boundBy: 0).staticTexts["25.0"]
        let inputValuteViewAfterSubstract = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element(boundBy: 0).staticTexts["48.0"]
        let inputValuteViewAfterMultiplyAndFold = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element(boundBy: 0).staticTexts["50.0"]
        let outputValuteViewAfterDivision = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["21.306705438382554"]
        let outputValuteViewAfterSubstract = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["40.90887444169451"]
        let outputValuteViewAfterMultiplyAndFold = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(
            matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).staticTexts["42.61341087676511"]
        
        
        //Деление
        divisionButton.tap()
        twoButton.tap()
        equalButton.tap()
        
        XCTAssertTrue(inputValuteViewAfterDivision.exists)
        XCTAssertTrue(outputValuteViewAfterDivision.exists)
        
        //Умножение
        multiplicationButton.tap()
        twoButton.tap()
        equalButton.tap()
        
        XCTAssertTrue(inputValuteViewAfterMultiplyAndFold.exists)
        XCTAssertTrue(outputValuteViewAfterMultiplyAndFold.exists)
        
        //Вычитание
        subtractButton.tap()
        twoButton.tap()
        equalButton.tap()
        
        XCTAssertTrue(inputValuteViewAfterSubstract.exists)
        XCTAssertTrue(outputValuteViewAfterSubstract.exists)

        //Прибавление
        foldButton.tap()
        twoButton.tap()
        equalButton.tap()
        
        XCTAssertTrue(inputValuteViewAfterMultiplyAndFold.exists)
        XCTAssertTrue(outputValuteViewAfterMultiplyAndFold.exists)
    }
}
