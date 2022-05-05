//
//  DetailController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit
import RealmSwift

class DetailController: UIViewController {
	
	let realm = try! Realm()
	
	var photo: Photo?
	var favPhoto: FavoritePhotos?
	
	private var likedPhotos: Results<FavoritePhotos>!
	private var customAlert = AlertView()
	
	// MARK: - VC Life Cycle
	override func loadView() {
		super.loadView()
		
		return self.view = DetailView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view().delegate = self
		view().photo = photo
		view().favPhoto = favPhoto
	}
	
	fileprivate func view() -> DetailView {
		return self.view as! DetailView
	}
	
	// MARK: - Alert
	fileprivate func addAlert() {
		customAlert.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.width / 2)
		customAlert.center = view.center
		customAlert.alpha = 0
		view.addSubview(customAlert)
		view.bringSubviewToFront(customAlert)
	}
	
	fileprivate func showAlert(isSaved: Bool) {
		addAlert()
		customAlert.isSaved = isSaved
		customAlert.animate(view: self.view)
	}
	
	fileprivate func showErrorAlert(message: String = "Unable to delete photo") {
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .destructive)
		
		alert.addAction(action)
		present(alert, animated: true)
	}
}

// MARK: - DetailViewControllerDelegate
extension DetailController: DetailViewControllerDelegate {
	/// Save fav photo to realm db
	func savePhoto(photo: FavoritePhotos) {
		do {
			try self.realm.write({
				self.realm.add(photo)
				self.showAlert(isSaved: true)
			})
		} catch let error {
			print("Unable to save", error.localizedDescription)
			let message = "Unable to save photos"
			self.showErrorAlert(message: message)
		}
	}
	
	/// Delete fav photo from realm db
	func deletePhoto(photo: FavoritePhotos) {
		let predicate = NSPredicate(format: "photoUrl=%@", photo.photoUrl)
		do {
			try realm.write({
				realm.delete(realm.objects(FavoritePhotos.self).filter(predicate))
				self.showAlert(isSaved: false)
			})
		} catch let error {
			print("Unable to delete", error.localizedDescription)
			self.showErrorAlert()
		}
	}
}
