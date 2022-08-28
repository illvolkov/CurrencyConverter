//
//  NetworkService.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 28.08.2022.
//

import Alamofire

class NetworkService {

    var view: CurrenciesController?

    func fetchData(with delegate: XMLParserDelegate, completion: @escaping () -> Void) {
        let url = "https://www.cbr.ru/scripts/XML_daily.asp"
        AF.request(url)
            .validate()
            .responseData { response in
                guard let data = response.value else {
                    let alert = UIAlertController(title: response.error?.errorDescription,
                                                  message: "",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    if let view = self.view {
                        view.present(alert, animated: true)
                    }
                    return
                }
                let xml = XMLParser(data: data)
                xml.delegate = delegate
                if xml.parse() {
                    completion()
                }
            }
    }
}
