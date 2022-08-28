//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit

class CurrenciesController: UIViewController {
    
    //MARK: - Private property
    
    private let segments = ["Все", "Избранное"]
    private var valutes = [Valute]()
    private var favoriteValutes = [FavoriteValutes]()
    private var elementName = String()
    private var valuteName = String()
    private var valuteCharCode = String()
    private var valuteValue = String()
    private let dataManager = DataManager()
    private let networkService = NetworkService()
        
    //MARK: - Views
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .gray
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.selectedSegmentTintColor = .black
        segmentedControl.addTarget(self, action: #selector(didSelect), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CurrenciesTableViewCell.self, forCellReuseIdentifier: CurrenciesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
        
        networkService.fetchData(with: self) {
            self.checkedSelectedValutes()
            self.tableView.reloadData()
        }
        valuteTransferFromMemory()
    }
    
    //MARK: - Settings
    
    private func setupHierarchy() {
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    //MARK: - Functions
    
    func didTapOnIndexPath(cell: UITableViewCell) {
        let indexPathTapped = tableView.indexPath(for: cell)
        
        guard let indexPath = indexPathTapped else { return }
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            if valutes[indexPath.row].isFavorite {
                deleteValute(for: indexPath)
            } else {
                addValute(for: indexPath)
            }
        case 1:
            deleteValuteFromFavorites(for: indexPath)
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    private func deleteValute(for indexPath: IndexPath) {
        valutes[indexPath.row].isFavorite = false
        for valute in favoriteValutes {
            if valute.name == valutes[indexPath.row].name {
                dataManager.delete(favoriteValute: valute)
            }
            let filter = favoriteValutes.filter { $0.name != nil }
            self.favoriteValutes = filter
        }
        valuteTransferFromMemory()
    }
    
    private func addValute(for indexPath: IndexPath) {
        self.valutes[indexPath.row].isFavorite = true
        dataManager.save(valute: valutes[indexPath.row])
        valuteTransferFromMemory()
    }
    
    private func deleteValuteFromFavorites(for indexPath: IndexPath) {
        for index in 0..<valutes.count {
            if valutes[index].name == favoriteValutes[indexPath.row].name {
                valutes[index].isFavorite = false
            }
        }
        dataManager.delete(favoriteValute: favoriteValutes[indexPath.row])
        valuteTransferFromMemory()
    }
    
    private func valuteTransferFromMemory() {
        dataManager.getFavoriteValutes {
            self.favoriteValutes = dataManager.favoriteValutes
        }
    }
    
    //Установка значения isFavorite в true если они уже есть в избранном
    private func checkedSelectedValutes() {
        for i in 0..<valutes.count {
            for j in 0..<favoriteValutes.count {
                if valutes[i].name == favoriteValutes[j].name {
                    valutes[i].isFavorite = true
                }
            }
        }
    }
    
    //MARK: - Actions
    
    @objc private func didSelect() {
        tableView.reloadData()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods

extension CurrenciesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return valutes.count
        case 1:
            return favoriteValutes.count
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrenciesTableViewCell.identifier,
            for: indexPath) as? CurrenciesTableViewCell else { return UITableViewCell() }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            cell.configure(with: valutes[indexPath.row])
        case 1:
            if !favoriteValutes.isEmpty {
                cell.configureFavorite(with: favoriteValutes[indexPath.row])
            }
        default:
            break
        }
        cell.view = self
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

extension CurrenciesController: XMLParserDelegate {
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "Valute" {
            valuteName = String()
            valuteValue = String()
            valuteCharCode = String()
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "Valute" {
            let valute = Valute(charCode: valuteCharCode, name: valuteName, value: valuteValue, isFavorite: false)
            valutes.append(valute)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if !data.isEmpty {
            if self.elementName == "Name" {
                valuteName += data
            } else if self.elementName == "CharCode" {
                valuteCharCode += data
            } else if self.elementName == "Value" {
                valuteValue += data
            }
        }
    }
}
