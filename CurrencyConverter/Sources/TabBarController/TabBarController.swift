//
//  TabBarController.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        generateTabBar()
        setupTabBar()
    }
    
    //MARK: - Settings
    
    private func generateTabBar() {
        viewControllers = [
            generate(viewController: CurrenciesController(),
                     title: Strings.exchangeRatesTabItemTitle,
                     image: UIImage(systemName: Images.exchangeRatesTabItemImage)),
            generate(viewController: CalculatorController(),
                     title: Strings.calculatorTabItemTitle,
                     image: UIImage(systemName: Images.calculatorTabItemImage))
        ]
    }
    
    private func generate(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
}
