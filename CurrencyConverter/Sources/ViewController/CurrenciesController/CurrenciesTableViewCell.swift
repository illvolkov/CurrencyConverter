//
//  CurrenciesTableViewCell.swift
//  CurrencyConverter
//
//  Created by Ilya Volkov on 23.08.2022.
//

import UIKit

class CurrenciesTableViewCell: UITableViewCell {
    
    //MARK: - Reference
    
    weak var view: CurrenciesController?
    
    //MARK: - Identifier
    
    static let identifier = "CurrenciesTableViewCell"
    
    //MARK: - Private property
    
    private var isFavorite: Bool = false {
        didSet {
            if !isFavorite {
                favoritesButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                favoritesButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
    //MARK: - Views
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.font = .systemFont(ofSize: contentView.frame.width * 0.045, weight: .semibold)
        name.textColor = .white
        return name
    }()
    
    private lazy var charLabel: UILabel = {
        let char = UILabel()
        char.font = .systemFont(ofSize: contentView.frame.width * 0.045, weight: .semibold)
        char.textColor = .white
        return char
    }()
    
    private lazy var valueLabel: UILabel = {
        let value = UILabel()
        value.font = .systemFont(ofSize: contentView.frame.width * 0.045, weight: .semibold)
        value.textColor = .white
        return value
    }()
    
    private lazy var favoritesButton: UIButton = {
        let favorites = UIButton(type: .system)
        favorites.tintColor = .white
        favorites.layer.masksToBounds = true
        favorites.setImage(UIImage(systemName: "heart"), for: .normal)
        favorites.addTarget(self, action: #selector(favoritesButtonDidTap), for: .touchUpInside)
        return favorites
    }()
    
    //MARK: - Initial
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupHierarchy()
        setupLayout()
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Settings
    
    private func setupHierarchy() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(charLabel)
        contentView.addSubview(valueLabel)
        contentView.addSubview(favoritesButton)
    }
        
    private func setupLayout() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -15).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 15).isActive = true
        valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        
        charLabel.translatesAutoresizingMaskIntoConstraints = false
        charLabel.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor).isActive = true
        charLabel.leftAnchor.constraint(equalTo: valueLabel.rightAnchor).isActive = true
        
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        favoritesButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        favoritesButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        favoritesButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1).isActive = true
        favoritesButton.heightAnchor.constraint(equalTo: favoritesButton.widthAnchor).isActive = true
    }
    
    private func setupContentView() {
        contentView.heightAnchor.constraint(equalToConstant: contentView.frame.width * 0.25).isActive = true
        contentView.backgroundColor = .black
        contentView.layer.cornerRadius = contentView.frame.width * 0.05
        contentView.isAccessibilityElement = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    //MARK: - Actions
    
    @objc private func favoritesButtonDidTap() {
        isFavorite.toggle()
        
        view?.didTapOnIndexPath(cell: self)
    }
    
    //MARK: - Configure
        
    func configure(with model: Valute) {
        nameLabel.text = model.name
        charLabel.text = " - \(model.charCode)"
        valueLabel.text = model.value
        isFavorite = model.isFavorite
    }
    
    func configureFavorite(with model: FavoriteValutes) {
        nameLabel.text = model.name
        charLabel.text = " - \(model.charCode ?? "")"
        valueLabel.text = model.value
        isFavorite = model.isFavorite
    }
}
