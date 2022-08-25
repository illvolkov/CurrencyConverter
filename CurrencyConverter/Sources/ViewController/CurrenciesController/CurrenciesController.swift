//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit
import Alamofire

class CurrenciesController: UIViewController {
    
    private let segments = ["Все", "Избранное"]
    private var valutes = [Valute]()
    private var elementName = String()
    private var valuteName = String()
    private var valuteCharCode = String()
    private var valuteValue = String()
    
    //MARK: - Views
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .gray
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControl.selectedSegmentTintColor = .black
        return segmentedControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CurrenciesTableViewCell.self, forCellReuseIdentifier: CurrenciesTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchData()
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
    
    private func fetchData() {
        let url = "https://www.cbr.ru/scripts/XML_daily.asp"
        AF.request(url)
            .validate()
            .responseData { response in
                guard let data = response.value else {
                    let alert = UIAlertController(title: response.error?.errorDescription,
                                                  message: "",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alert, animated: true)
                    return
                }
                let xml = XMLParser(data: data)
                xml.delegate = self
                if xml.parse() {
                    self.tableView.reloadData()
                }
            }
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource methods

extension CurrenciesController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        valutes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = valutes[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CurrenciesTableViewCell.identifier,
            for: indexPath) as? CurrenciesTableViewCell else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
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
            let valute = Valute(charCode: valuteCharCode, name: valuteName, value: valuteValue)
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
