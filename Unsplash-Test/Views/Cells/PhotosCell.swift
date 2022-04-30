//
//  PhotosCell.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit

class PhotosCell: UICollectionViewCell {
	
	fileprivate let imageView: UIImageView =  {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.image = UIImage(systemName: "person.fill")
		return iv
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupImageView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
//		imageView.image = nil
	}
	
	fileprivate func setupImageView() {
		contentView.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
		])
	}
	
}
