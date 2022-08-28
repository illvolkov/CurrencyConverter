//
//  CalculatorController.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit

class CalculatorController: UIViewController {
    
    //MARK: - Views
    
    private lazy var inputLabel = createInputOutputLabel(font: view.frame.width * 0.13)
    private lazy var outputLabel = createInputOutputLabel(font: view.frame.width * 0.13)
    private lazy var inputValute = createInputOutputLabel(font: view.frame.width * 0.07)
    private lazy var outputValute = createInputOutputLabel(font: view.frame.width * 0.07)
    private lazy var inputValuteView = createInputOutputView()
    private lazy var outputValuteView = createInputOutputView()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var hStackOne = createHStack()
    private lazy var hStackTwo = createHStack()
    private lazy var hStackThree = createHStack()
    private lazy var hStackFour = createHStack()
    private lazy var hStackFive = createHStack(with: .fillProportionally)
    
    private lazy var eraseAllButton = createCalculatorButton(by: "C", color: .black)
    private lazy var eraseButton = createCalculatorButton(by: "←", color: .black)
    private lazy var swapValutes = createCalculatorButton(by: "⇅", color: .black)
    private lazy var divisionButton = createCalculatorButton(by: "/", color: .red)
    
    private lazy var sevenButton = createCalculatorButton(by: "7", color: .black)
    private lazy var eightButton = createCalculatorButton(by: "8", color: .black)
    private lazy var nineButton = createCalculatorButton(by: "9", color: .black)
    private lazy var multiplicationButton = createCalculatorButton(by: "X", color: .red)
    
    private lazy var fourButton = createCalculatorButton(by: "4", color: .black)
    private lazy var fiveButton = createCalculatorButton(by: "5", color: .black)
    private lazy var sixButton = createCalculatorButton(by: "6", color: .black)
    private lazy var subtractButton = createCalculatorButton(by: "-", color: .red)
    
    private lazy var oneButton = createCalculatorButton(by: "1", color: .black)
    private lazy var twoButton = createCalculatorButton(by: "2", color: .black)
    private lazy var threeButton = createCalculatorButton(by: "3", color: .black)
    private lazy var foldButton = createCalculatorButton(by: "+", color: .red)
    
    private lazy var zeroButton = createCalculatorButton(by: "0", color: .black)
    private lazy var commaButton = createCalculatorButton(by: ",", color: .black)
    private lazy var equalButton = createCalculatorButton(by: "=", color: .red)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
        commonInit()
    }
    
    private func commonInit() {
        inputLabel.text = "0"
        outputLabel.text = "0"
        inputValute.text = "USD"
        outputValute.text = "USD"
    }
    
    //MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubview(inputValuteView)
        view.addSubview(outputValuteView)
        
        inputValuteView.addSubview(inputValute)
        inputValuteView.addSubview(inputLabel)
        outputValuteView.addSubview(outputValute)
        outputValuteView.addSubview(outputLabel)
        
        view.addSubview(vStack)
        
        vStack.addArrangedSubview(hStackOne)
        vStack.addArrangedSubview(hStackTwo)
        vStack.addArrangedSubview(hStackThree)
        vStack.addArrangedSubview(hStackFour)
        vStack.addArrangedSubview(hStackFive)
        
        hStackOne.addArrangedSubview(eraseAllButton)
        hStackOne.addArrangedSubview(eraseButton)
        hStackOne.addArrangedSubview(swapValutes)
        hStackOne.addArrangedSubview(divisionButton)
        
        hStackTwo.addArrangedSubview(sevenButton)
        hStackTwo.addArrangedSubview(eightButton)
        hStackTwo.addArrangedSubview(nineButton)
        hStackTwo.addArrangedSubview(multiplicationButton)
        
        hStackThree.addArrangedSubview(fourButton)
        hStackThree.addArrangedSubview(fiveButton)
        hStackThree.addArrangedSubview(sixButton)
        hStackThree.addArrangedSubview(subtractButton)
        
        hStackFour.addArrangedSubview(oneButton)
        hStackFour.addArrangedSubview(twoButton)
        hStackFour.addArrangedSubview(threeButton)
        hStackFour.addArrangedSubview(foldButton)
        
        hStackFive.addArrangedSubview(zeroButton)
        hStackFive.addArrangedSubview(commaButton)
        hStackFive.addArrangedSubview(equalButton)
    }
    
    private func setupLayout() {
        inputValuteView.translatesAutoresizingMaskIntoConstraints = false
        inputValuteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        inputValuteView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputValuteView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        inputValuteView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
        outputValuteView.translatesAutoresizingMaskIntoConstraints = false
        outputValuteView.topAnchor.constraint(equalTo: inputValuteView.bottomAnchor, constant: 1).isActive = true
        outputValuteView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        outputValuteView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        outputValuteView.heightAnchor.constraint(equalTo: inputValuteView.heightAnchor).isActive = true
        
        inputValute.translatesAutoresizingMaskIntoConstraints = false
        inputValute.leftAnchor.constraint(equalTo: inputValuteView.leftAnchor, constant: 10).isActive = true
        inputValute.centerYAnchor.constraint(equalTo: inputValuteView.centerYAnchor).isActive = true
        
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.rightAnchor.constraint(equalTo: inputValuteView.rightAnchor, constant: -10).isActive = true
        inputLabel.centerYAnchor.constraint(equalTo: inputValuteView.centerYAnchor).isActive = true
        inputLabel.widthAnchor.constraint(equalTo: inputValuteView.widthAnchor, multiplier: 0.6).isActive = true
        
        outputValute.translatesAutoresizingMaskIntoConstraints = false
        outputValute.leftAnchor.constraint(equalTo: outputValuteView.leftAnchor, constant: 10).isActive = true
        outputValute.centerYAnchor.constraint(equalTo: outputValuteView.centerYAnchor).isActive = true
        
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.rightAnchor.constraint(equalTo: outputValuteView.rightAnchor, constant: -10).isActive = true
        outputLabel.centerYAnchor.constraint(equalTo: outputValuteView.centerYAnchor).isActive = true
        outputLabel.widthAnchor.constraint(equalTo: inputLabel.widthAnchor).isActive = true
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.topAnchor.constraint(equalTo: outputValuteView.bottomAnchor).isActive = true
        vStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        zeroButton.widthAnchor.constraint(equalTo: hStackFive.widthAnchor, multiplier: 0.417).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .black
    }
    
    //MARK: - Functions
    
    private func createInputOutputLabel(font: CGFloat) -> UILabel {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: font, weight: .semibold)
        return label
    }
    
    private func createInputOutputView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    private func createHStack(with distribution: UIStackView.Distribution? = .fillEqually) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = distribution ?? .fillEqually
        return stack
    }
    
    private func createCalculatorButton(by title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: view.frame.width * 0.07)
        button.backgroundColor = color
        return button
    }
}
