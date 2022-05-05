//
//  PhotosCell.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {
	
	var photo: Photo? {
		didSet {
			guard let photo = photo else { return }
			imageView.sd_setImage(with: URL(string:photo.urls.small))
		}
	}
	
	// MARK: - UI Components
	fileprivate let imageView: UIImageView =  {
		let iv = UIImageView()
		iv.contentMode = .scaleAspectFill
		iv.clipsToBounds = true
		iv.translatesAutoresizingMaskIntoConstraints = false
		iv.image = UIImage(systemName: "person.fill")
		return iv
	}()
	
	fileprivate let conteinerView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.clipsToBounds = true
		view.backgroundColor = .gray
		return view
	}()
	
	// MARK: - Init
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupImageView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		imageView.image = nil
	}
	
	// MARK: - Fileprivate methods
	fileprivate func setupImageView() {
		conteinerView.addSubview(imageView)
		conteinerView.layer.cornerRadius = 10
		
		contentView.addSubview(conteinerView)
		
		NSLayoutConstraint.activate([
			
			conteinerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
			conteinerView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
			
			imageView.widthAnchor.constraint(equalTo: conteinerView.widthAnchor),
			imageView.heightAnchor.constraint(equalTo: conteinerView.heightAnchor),
		])
	}
	
}
