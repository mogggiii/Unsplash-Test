//
//  DetailView.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import Foundation
import UIKit

class DetailView: UIView {
	
	private let imageView: UIImageView = {
		let iv = UIImageView()
		iv.backgroundColor = .black
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	
	private let addToFavoriteButton: UIButton = {
		let button = UIButton()
		var config = UIImage.SymbolConfiguration.init(pointSize: 30, weight: .semibold)
		button.setImage(UIImage(systemName: "heart")?.withConfiguration(config), for: .normal)
		button.tintColor = UIColor(red: 255 / 255, green: 3 / 255, blue: 114 / 255, alpha: 1)
		return button
	}()
	
	private let authorAndDateLabel: UILabel = {
		let label = UILabel()
		label.text = "By: Tinkoff\nDate: 24.09.1999"
		label.font = .systemFont(ofSize: 16)
		label.numberOfLines = 2
		return label
	}()
	
	private let placeAndDownloadCountLabel: UILabel = {
		let label = UILabel()
		label.text = "London\n29999 downloads"
		label.font = .systemFont(ofSize: 16)
		label.numberOfLines = 2
		label.textAlignment = .right
		return label
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .white
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupLayout() {
		
		let stackView = UIStackView(arrangedSubviews: [authorAndDateLabel, placeAndDownloadCountLabel])
		stackView.distribution = .fill
		stackView.axis = .horizontal
		
		addSubview(imageView)
		addSubview(addToFavoriteButton)
		addSubview(stackView)
		
		let screenSize = UIScreen.main.bounds
		let buttonSize: CGFloat = 50
		
		imageView.layer.cornerRadius = 20
		imageView.frame = CGRect(x: 16, y: 100, width: screenSize.size.width - 32, height: 300)
		
		addToFavoriteButton.frame = CGRect(x: imageView.frame.width - 44, y: imageView.frame.maxY - buttonSize / 2, width: buttonSize, height: buttonSize)
		addToFavoriteButton.layer.cornerRadius = buttonSize / 2
		
		stackView.frame = CGRect(x: 16, y: addToFavoriteButton.frame.maxY + 20, width: screenSize.size.width - 32, height: 60)
//		placeAndCountViewsLabel.frame = CGRect(x: screenSize.maxX - 16, y: addToFavoriteButton.frame.maxY + 20, width: 150, height: 60)
	}
	
}
