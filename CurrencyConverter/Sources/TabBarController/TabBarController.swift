//
//  TabBarController.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit
import XMLCoder

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
                     title: "Курсы валют",
                     image: UIImage(systemName: "dollarsign.circle")),
            generate(viewController: CalculatorController(),
                     title: "Калькулятор",
                     image: UIImage(systemName: "equal.circle")),
            generate(viewController: FavoritesController(),
                     title: "Избранное",
                     image: UIImage(systemName: "star.circle"))
        ]
    }
    
    private func generate(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .black
    }
}
