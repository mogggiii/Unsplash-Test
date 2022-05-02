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
	
	private var likedPhotos: Results<FavoritePhotos>!
	private var photo: PhotoData
//	private var favPhoto: FavoritePhotos
	
	override func loadView() {
		super.loadView()
		
		return self.view = DetailView()
	}
	
	init(photo: PhotoData) {
		self.photo = photo
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view().delegate = self
		view().photo = photo
	}
	
	fileprivate func view() -> DetailView {
		return self.view as! DetailView
	}
}

extension DetailController: DetailViewControllerDelegate {
	func savePhoto(photo: FavoritePhotos) {
		do {
			try self.realm.write({
				self.realm.add(photo)
				print("Save")
			})
		} catch {
			print("NO SUCCESS")
		}
	}
	
	func deletePhoto(photo: FavoritePhotos) {
		let predicate = NSPredicate(format: "photoUrl=%@", photo.photoUrl)
		do {
			try realm.write({
				realm.delete(realm.objects(FavoritePhotos.self).filter(predicate))
				print("Delete")
			})
		} catch let error {
			print(error.localizedDescription)
			print("NO SUCCESS 2")
		}
	}
	
}
