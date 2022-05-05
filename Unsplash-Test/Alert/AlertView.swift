//
//  AlertView.swift
//  Unsplash-Test
//
//  Created by mogggiii on 03.05.2022.
//

import UIKit

class AlertView: UIVisualEffectView {
	
	var isSaved: Bool? {
		didSet {
			guard let isSaved = isSaved else { return }
			let config = UIImage.SymbolConfiguration.init(pointSize: 90)
			if isSaved {
				textLabel.text = "Saved"
				imageView.image = UIImage(systemName: "checkmark")?.withConfiguration(config)
			} else {
				textLabel.text = "Deleted"
				imageView.image = UIImage(systemName: "multiply.circle")?.withConfiguration(config)
			}
		}
	}
	
	// MARK: - UI Components
	fileprivate let textLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 22, weight: .semibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = .white
		label.text = "Saved"
		label.textAlignment = .center
		return label
	}()
	
	fileprivate let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.clipsToBounds = true
		imageView.tintColor = .white
		return imageView
	}()
	
	override init(effect: UIVisualEffect?) {
		super.init(effect: UIBlurEffect(style: .dark))
		
		self.layer.cornerRadius = 25
		self.clipsToBounds = true
		
		setupAlert()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	fileprivate func setupAlert() {
		contentView.addSubview(textLabel)
		contentView.addSubview(imageView)
		
		NSLayoutConstraint.activate([
			imageView.widthAnchor.constraint(equalToConstant: 100),
			imageView.heightAnchor.constraint(equalToConstant: 100),
			imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			
			textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
			textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			
		])
	}
}

// MARK: - Animation Methods

extension AlertView {
	func animate(view: UIView) {
		view.isUserInteractionEnabled = false
		UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
			self.alpha = 1
		} completion: { _ in
			self.animateOut(view: view)
		}
	}
	
	fileprivate func animateOut(view: UIView) {
		UIView.animate(withDuration: 0.7, delay: 0.5, options: .curveEaseOut) {
			self.alpha = 0
		} completion: { _ in
			view.isUserInteractionEnabled = true
			self.removeFromSuperview()
		}
	}
}
