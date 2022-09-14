//
//  CalculatorController.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit

class CalculatorController: UIViewController, CurrenciesControllerDelegate {
    
    //MARK: - Private property
    
    private let currenciesController = CurrenciesController()
    private var isSwapValutes = false {
        didSet {
            guard inputValuteSelected != nil && outputValuteSelected != nil ||
                    inputFavoriteValuteSelected != nil && outputFavoriteValuteSelected != nil ||
                    inputValuteSelected != nil && outputFavoriteValuteSelected != nil ||
                    inputFavoriteValuteSelected != nil && outputValuteSelected != nil
            else { return }
            
            if isSwapValutes {
                movingState()
                guard outputLabel.text != Strings.zeroTitle else { return }
                outputLabel.text =  String(calculateSwapRate())
            } else {
                returnToOriginalState()
                guard outputLabel.text != Strings.zeroTitle else { return }
                outputLabel.text =  String(calculateRate())

            }
        }
    }
    private var firstNumber: Double = 0
    private var secondNumber: Double = 0
    private var operation = 0
    private var mathSign = false
    private var amount: Double = 0
    
    //MARK: - Global property
    
    var isFavoriteSelected = false
    var isInputFavoriteSelected = false
    var isOutputFavoriteSelected = false
    var inputValuteSelected: Valute?
    var outputValuteSelected: Valute?
    var inputFavoriteValuteSelected: FavoriteValutes?
    var outputFavoriteValuteSelected: FavoriteValutes?
    
    //MARK: - Views
    
    private lazy var inputLabel = createInputOutputLabel(font: view.frame.width * Sizes.labelFontSize0_13)
    private lazy var outputLabel = createInputOutputLabel(font: view.frame.width * Sizes.labelFontSize0_13)
    private lazy var inputValute = createInputOutputLabel(font: view.frame.width * Sizes.fontSize0_07)
    private lazy var outputValute = createInputOutputLabel(font: view.frame.width * Sizes.fontSize0_07)
    private lazy var inputValuteView = createInputOutputView(action: #selector(inputValuteViewDidTap))
    private lazy var outputValuteView = createInputOutputView(action: #selector(outputValuteViewDidTap))
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var hStackOne = createHStack(with: .fillProportionally)
    private lazy var hStackTwo = createHStack()
    private lazy var hStackThree = createHStack()
    private lazy var hStackFour = createHStack()
    private lazy var hStackFive = createHStack(with: .fillProportionally)
    
    private lazy var zeroButton = createCalculatorButton(by: Strings.zeroTitle, tag: ButtonTags.zeroButtonTag)
    private lazy var oneButton = createCalculatorButton(by: Strings.oneTitle, tag: ButtonTags.oneButtonTag)
    private lazy var twoButton = createCalculatorButton(by: Strings.twoTitle, tag: ButtonTags.twoButtonTag)
    private lazy var threeButton = createCalculatorButton(by: Strings.threeTitle, tag: ButtonTags.threeButtonTag)
    private lazy var fourButton = createCalculatorButton(by: Strings.fourTitle, tag: ButtonTags.fourButtonTag)
    private lazy var fiveButton = createCalculatorButton(by: Strings.fiveTitle, tag: ButtonTags.fiveButtonTag)
    private lazy var sixButton = createCalculatorButton(by: Strings.sixTitle, tag: ButtonTags.sixButtonTag)
    private lazy var sevenButton = createCalculatorButton(by: Strings.sevenTitle, tag: ButtonTags.sevenButtonTag)
    private lazy var eightButton = createCalculatorButton(by: Strings.eightTitle, tag: ButtonTags.eightButtonTag)
    private lazy var nineButton = createCalculatorButton(by: Strings.nineTitle, tag: ButtonTags.nineButtonTag)
    private lazy var eraseAllButton = createCalculatorButton(by: Strings.eraseAllTitle,
                                                             tag: ButtonTags.eraseAllButtonTag,
                                                             action: #selector(calculatorControl))
    private lazy var swapValutes = createCalculatorButton(by: Strings.swapTitle,
                                                          tag: ButtonTags.swapButtonTag,
                                                          action: #selector(calculatorControl))
    private lazy var divisionButton = createCalculatorButton(by: Strings.divisionTitle,
                                                             color: .red,
                                                             tag: ButtonTags.divisionButtonTag,
                                                             action: #selector(calculatorControl))
    private lazy var multiplicationButton = createCalculatorButton(by: Strings.multiplicationTitle,
                                                                   color: .red,
                                                                   tag: ButtonTags.multiplicationButtonTag,
                                                                   action: #selector(calculatorControl))
    private lazy var subtractButton = createCalculatorButton(by: Strings.substractTitle,
                                                             color: .red,
                                                             tag: ButtonTags.substractButtonTag,
                                                             action: #selector(calculatorControl))
    private lazy var foldButton = createCalculatorButton(by: Strings.foldTitle,
                                                         color: .red,
                                                         tag: ButtonTags.foldButtonTag,
                                                         action: #selector(calculatorControl))
    private lazy var equalButton = createCalculatorButton(by: Strings.equalTitle,
                                                          color: .red,
                                                          tag: ButtonTags.equalButtonTag,
                                                          action: #selector(calculatorControl))
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
        commonInit()
    }
    
    //MARK: - Initial
    
    private func commonInit() {
        inputLabel.text = Strings.zeroTitle
        outputLabel.text = Strings.zeroTitle
        inputValute.text = Strings.selectValuteTitle
        outputValute.text = Strings.selectValuteTitle
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
        hStackFive.addArrangedSubview(equalButton)
    }
    
    private func setupLayout() {
        inputValuteView.translatesAutoresizingMaskIntoConstraints = false
        inputValuteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        inputValuteView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        inputValuteView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        inputValuteView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: Sizes.inputValuteViewHeightSize).isActive = true
        
        outputValuteView.translatesAutoresizingMaskIntoConstraints = false
        outputValuteView.topAnchor.constraint(equalTo: inputValuteView.bottomAnchor, constant: Offsets.outputValuteViewBottomOffset).isActive = true
        outputValuteView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        outputValuteView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        outputValuteView.heightAnchor.constraint(equalTo: inputValuteView.heightAnchor).isActive = true
        
        inputValute.translatesAutoresizingMaskIntoConstraints = false
        inputValute.leftAnchor.constraint(equalTo: inputValuteView.leftAnchor, constant: Offsets.leftOffset10).isActive = true
        inputValute.centerYAnchor.constraint(equalTo: inputValuteView.centerYAnchor).isActive = true
        
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.rightAnchor.constraint(equalTo: inputValuteView.rightAnchor, constant: Offsets.rightOffset_10).isActive = true
        inputLabel.centerYAnchor.constraint(equalTo: inputValuteView.centerYAnchor).isActive = true
        inputLabel.widthAnchor.constraint(equalTo: inputValuteView.widthAnchor, multiplier: Sizes.inputLabelWidthSize).isActive = true
        
        outputValute.translatesAutoresizingMaskIntoConstraints = false
        outputValute.leftAnchor.constraint(equalTo: outputValuteView.leftAnchor, constant: Offsets.leftOffset10).isActive = true
        outputValute.centerYAnchor.constraint(equalTo: outputValuteView.centerYAnchor).isActive = true
        
        outputLabel.translatesAutoresizingMaskIntoConstraints = false
        outputLabel.rightAnchor.constraint(equalTo: outputValuteView.rightAnchor, constant: Offsets.rightOffset_10).isActive = true
        outputLabel.centerYAnchor.constraint(equalTo: outputValuteView.centerYAnchor).isActive = true
        outputLabel.widthAnchor.constraint(equalTo: inputLabel.widthAnchor).isActive = true
        
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.topAnchor.constraint(equalTo: outputValuteView.bottomAnchor).isActive = true
        vStack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        vStack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        vStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        zeroButton.translatesAutoresizingMaskIntoConstraints = false
        zeroButton.widthAnchor.constraint(equalTo: hStackFive.widthAnchor, multiplier: Sizes.zeroButtonWidthSize).isActive = true
        
        eraseAllButton.translatesAutoresizingMaskIntoConstraints = false
        eraseAllButton.widthAnchor.constraint(equalTo: hStackOne.widthAnchor, multiplier: Sizes.widthSize0_375).isActive = true
        
        swapValutes.translatesAutoresizingMaskIntoConstraints = false
        swapValutes.widthAnchor.constraint(equalTo: hStackOne.widthAnchor, multiplier: Sizes.widthSize0_375).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
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
    
    private func createInputOutputView(action: Selector) -> UIView {
        let view = UIView()
        let tap = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tap)
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }
    
    private func createHStack(with distribution: UIStackView.Distribution? = .fillEqually) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = distribution ?? .fillEqually
        return stack
    }
    
    private func createCalculatorButton(by title: String,
                                        color: UIColor? = .black,
                                        tag: Int,
                                        action: Selector? = #selector(enteringNumbers)) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: view.frame.width * Sizes.fontSize0_07)
        button.backgroundColor = color
        if let action = action {
            button.addTarget(self, action: action, for: .touchUpInside)
            button.addTarget(self, action: action, for: .touchUpInside)
        }
        button.tag = tag
        return button
    }
    
    func setupInputValute() {
        if isFavoriteSelected {
            inputValute.text = inputFavoriteValuteSelected?.charCode
        } else {
            inputValute.text = inputValuteSelected?.charCode
        }
    }
    
    func setupOutputValute() {
        if isFavoriteSelected {
            outputValute.text = outputFavoriteValuteSelected?.charCode
        } else {
            outputValute.text = outputValuteSelected?.charCode
        }
    }
    
    private func movingState() {
        if isInputFavoriteSelected && isOutputFavoriteSelected {
            outputValute.text = inputFavoriteValuteSelected?.charCode
            inputValute.text = outputFavoriteValuteSelected?.charCode
        } else if isInputFavoriteSelected && !isOutputFavoriteSelected {
            outputValute.text = inputFavoriteValuteSelected?.charCode
            inputValute.text = outputValuteSelected?.charCode
        } else if !isInputFavoriteSelected && isOutputFavoriteSelected {
            inputValute.text = outputFavoriteValuteSelected?.charCode
            outputValute.text = inputValuteSelected?.charCode
        } else {
            inputValute.text = outputValuteSelected?.charCode
            outputValute.text = inputValuteSelected?.charCode
        }
    }
    
    private func returnToOriginalState() {
        if isInputFavoriteSelected && isOutputFavoriteSelected {
            outputValute.text = outputFavoriteValuteSelected?.charCode
            inputValute.text = inputFavoriteValuteSelected?.charCode
        } else if isInputFavoriteSelected && !isOutputFavoriteSelected {
            outputValute.text = outputValuteSelected?.charCode
            inputValute.text = inputFavoriteValuteSelected?.charCode
        } else if !isInputFavoriteSelected && isOutputFavoriteSelected {
            outputValute.text = outputFavoriteValuteSelected?.charCode
            inputValute.text = inputValuteSelected?.charCode
        } else {
            outputValute.text = outputValuteSelected?.charCode
            inputValute.text = inputValuteSelected?.charCode
        }
    }
    
    private func calculateSwapRate() -> Double {
        
        let inputFavoriteValue = valueFormatting(with: inputFavoriteValuteSelected?.value ?? "")
        let inputValue = valueFormatting(with: inputValuteSelected?.value ?? "")
        let outputFavoriteValue = valueFormatting(with: outputFavoriteValuteSelected?.value ?? "")
        let outputValue = valueFormatting(with: outputValuteSelected?.value ?? "")
        
        if isInputFavoriteSelected && isOutputFavoriteSelected {
            amount = inputFavoriteValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / outputFavoriteValue
        } else if isInputFavoriteSelected && !isOutputFavoriteSelected {
            amount = inputFavoriteValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / outputValue
        } else if !isInputFavoriteSelected && isOutputFavoriteSelected {
            amount = inputValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / outputFavoriteValue
        } else {
            amount = inputValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / outputValue
        }
    }
    
    private func calculateRate() -> Double {
                
        let inputFavoriteValue = valueFormatting(with: inputFavoriteValuteSelected?.value ?? "")
        let inputValue = valueFormatting(with: inputValuteSelected?.value ?? "")
        let outputFavoriteValue = valueFormatting(with: outputFavoriteValuteSelected?.value ?? "")
        let outputValue = valueFormatting(with: outputValuteSelected?.value ?? "")
        
        if isInputFavoriteSelected && isOutputFavoriteSelected {
            amount = outputFavoriteValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / inputFavoriteValue
        } else if isInputFavoriteSelected && !isOutputFavoriteSelected {
            amount = outputValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / inputFavoriteValue
        } else if !isInputFavoriteSelected && isOutputFavoriteSelected {
            amount = outputFavoriteValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / inputValue
        } else {
            amount = outputValue * (Double(inputLabel.text ?? "") ?? 0.0)
            return amount / inputValue
        }
    }
    
    private func valueFormatting(with value: String) -> Double {
        var characters = [Character]()
        var newString = ""
        for char in value {
            characters.append(char)
        }
        for i in 0..<characters.count {
            if characters[i] == "," {
                characters[i] = "."
            }
            
            newString.append(characters[i])
        }
        return Double(newString) ?? 0.0
    }
    
    //MARK: - Actions
    
    @objc private func inputValuteViewDidTap() {
        currenciesController.delegate = self
        currenciesController.isInputSelected = true
        present(currenciesController, animated: true)
    }
    
    @objc private func outputValuteViewDidTap() {
        currenciesController.delegate = self
        currenciesController.isInputSelected = false
        present(currenciesController, animated: true)
    }
    
    @objc private func enteringNumbers(_ sender: UIButton) {
        guard inputValuteSelected != nil && outputValuteSelected != nil ||
                inputFavoriteValuteSelected != nil && outputFavoriteValuteSelected != nil ||
                inputValuteSelected != nil && outputFavoriteValuteSelected != nil ||
                inputFavoriteValuteSelected != nil && outputValuteSelected != nil
        else { return }
        
        if mathSign || inputLabel.text == Strings.zeroTitle {
            inputLabel.text = String(sender.tag)
            mathSign = false
        } else {
            inputLabel.text = (inputLabel.text ?? "") + String(sender.tag)
        }
        
        firstNumber = Double(inputLabel.text ?? "") ?? 0.0
        outputLabel.text = isSwapValutes ? String(calculateSwapRate()) : String(calculateRate())
    }
    
    @objc private func calculatorControl(_ sender: UIButton) {
        
        if inputLabel.text != Strings.zeroTitle && sender.tag != ButtonTags.eraseAllButtonTag && sender.tag != ButtonTags.swapButtonTag &&
        sender.tag != ButtonTags.equalButtonTag {
            secondNumber = Double(inputLabel.text ?? "") ?? 0.0
            
            if sender.tag == ButtonTags.divisionButtonTag {
                inputLabel.text = Strings.divisionTitle
            } else if sender.tag == ButtonTags.multiplicationButtonTag {
                inputLabel.text = Strings.multiplicationTitle
            } else if sender.tag == ButtonTags.substractButtonTag {
                inputLabel.text = Strings.substractTitle
            } else if sender.tag == ButtonTags.foldButtonTag {
                inputLabel.text = Strings.foldTitle
            }
            
            operation = sender.tag
            mathSign = true
        } else if sender.tag == ButtonTags.equalButtonTag && inputLabel.text != Strings.zeroTitle {
            if operation == ButtonTags.divisionButtonTag {
                inputLabel.text = String(secondNumber / firstNumber)
            } else if operation == ButtonTags.multiplicationButtonTag {
                inputLabel.text = String(firstNumber * secondNumber)
            } else if operation == ButtonTags.substractButtonTag {
                inputLabel.text = String(secondNumber - firstNumber)
            } else if operation == ButtonTags.foldButtonTag {
                inputLabel.text = String(firstNumber + secondNumber)
            }
            outputLabel.text =  isSwapValutes ? String(calculateSwapRate()) : String(calculateRate())
        } else if sender.tag == ButtonTags.swapButtonTag {
            isSwapValutes.toggle()
        } else {
            inputLabel.text = Strings.zeroTitle
            outputLabel.text = Strings.zeroTitle
            firstNumber = 0
            secondNumber = 0
            operation = 0
        }
    }
}
