//
//  LikedPhotosCell.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit

class LikedPhotosCell: UITableViewCell {
	
	let photoSize: CGFloat = 55
	
	let photo: UIImageView = {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.image = UIImage(systemName: "person.fill")
		iv.backgroundColor = .gray
		iv.layer.borderColor = UIColor.white.cgColor
		iv.layer.borderWidth = 2
		return iv
	}()
	
	let authorNameLabel: UILabel = {
		let label = UILabel()
		label.text = "Vladimir Ptitsa"
		label.font = .systemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		setupCell()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupCell() {
		
		contentView.addSubview(photo)
		contentView.addSubview(authorNameLabel)
		
		photo.layer.cornerRadius = photoSize / 2
		
		NSLayoutConstraint.activate([
			photo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			photo.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			photo.widthAnchor.constraint(equalToConstant: photoSize),
			photo.heightAnchor.constraint(equalToConstant: photoSize),
			
			authorNameLabel.centerYAnchor.constraint(equalTo: photo.centerYAnchor),
			authorNameLabel.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 20),
		])
	}
	
}