//
//  DetailView.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import Foundation
import UIKit

// MARK: - DetailViewControllerDelegate
protocol DetailViewControllerDelegate: AnyObject {
	func savePhoto(photo: FavoritePhotos)
	func deletePhoto(photo: FavoritePhotos)
}

class DetailView: UIView {
	
	var photo: Photo? {
		didSet {
			guard let photo = photo else { return }
			let df = DateFormatter()
			imageView.sd_setImage(with: URL(string: photo.urls.regular))
			authorAndDateLabel.text = "By: \(photo.user.username)\nDate: \(df.format().string(from: photo.createdAt))"
			placeAndLikesCountLabel.text = "\(photo.user.location ?? "No Location")\n\(photo.likes) likes"
		}
	}
	
	var favPhoto: FavoritePhotos? {
		didSet {
			guard let favPhoto = favPhoto else { return }
			imageView.sd_setImage(with: URL(string: favPhoto.photoUrl))
			authorAndDateLabel.text = "By: \(favPhoto.userName)\nDate: \(favPhoto.createdAT)"
			placeAndLikesCountLabel.text = "\(favPhoto.location ?? "No Location")\n\(favPhoto.likesCount) downloads"
			addToFavoriteButton.isHidden = true
		}
	}
	
	/// delegate
	weak var delegate: DetailViewControllerDelegate?
	
	// MARK: - UIComponents
	private let imageView: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFit
		return iv
	}()
	
	let addToFavoriteButton: UIButton = {
		let button = UIButton()
		var config = UIImage.SymbolConfiguration.init(pointSize: 30, weight: .semibold)
		button.setImage(UIImage(systemName: "heart")?.withConfiguration(config), for: .normal)
		button.tintColor = UIColor(red: 255 / 255, green: 3 / 255, blue: 114 / 255, alpha: 1)
		button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
		return button
	}()
	
	private let authorAndDateLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 16)
		label.numberOfLines = 3
		return label
	}()
	
	private let placeAndLikesCountLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 16)
		label.numberOfLines = 2
		label.textAlignment = .right
		return label
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .systemBackground
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Fileprivate methods
	fileprivate func setupLayout() {
		let screenSize = UIScreen.main.bounds
		let buttonSize: CGFloat = 50
		
		let stackView = UIStackView(arrangedSubviews: [authorAndDateLabel, placeAndLikesCountLabel])
		stackView.distribution = .fill
		stackView.axis = .horizontal
		
		addSubview(imageView)
		addSubview(addToFavoriteButton)
		addSubview(stackView)
		
		imageView.layer.cornerRadius = 20
		imageView.frame = CGRect(x: 16, y: 100, width: screenSize.size.width - 32, height: 300)
		
		addToFavoriteButton.frame = CGRect(x: imageView.frame.width - 44, y: imageView.frame.maxY - buttonSize / 2, width: buttonSize, height: buttonSize)
		addToFavoriteButton.layer.cornerRadius = buttonSize / 2
		
		stackView.frame = CGRect(x: 16, y: addToFavoriteButton.frame.maxY + 20, width: screenSize.size.width - 32, height: 90)
	}
	
	// MARK: - Objc fileprivate methods
	@objc fileprivate func handleLike() {
		let config = UIImage.SymbolConfiguration.init(pointSize: 30, weight: .semibold)
		photo?.isFavoritePhoto.toggle()
		print("Pressed")
		if photo?.isFavoritePhoto == true {
			addToFavoriteButton.setImage(UIImage(systemName: "heart.fill")?.withConfiguration(config), for: .normal)
			delegate?.savePhoto(photo: (self.photo?.toFavoritePhotoModel())!)
		} else {
			addToFavoriteButton.setImage(UIImage(systemName: "heart")?.withConfiguration(config), for: .normal)
			delegate?.deletePhoto(photo: (self.photo?.toFavoritePhotoModel())!)
		}
	}
}
