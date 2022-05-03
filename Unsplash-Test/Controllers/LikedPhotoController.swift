//
//  LikedPhotoController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit
import RealmSwift

class LikedPhotoController: UITableViewController {
	
	let realm = try! Realm()
	var photos: Results<FavoritePhotos>!
	
	private let cellId = "cellId"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.register(LikedPhotosCell.self, forCellReuseIdentifier: cellId)
		loadPhotos()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadPhotos()
	}
	
	fileprivate func loadPhotos() {
		photos = realm.objects(FavoritePhotos.self)
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	
	// MARK: - Table view data source
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return photos.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? LikedPhotosCell else {
			return UITableViewCell()
		}
		let photo = photos[indexPath.row]
		cell.favPhoto = photo
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favPhoto = photos[indexPath.row]
		let vc = DetailController()
		vc.favPhoto = favPhoto
		navigationController?.pushViewController(vc, animated: true)
	}

	override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .delete
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let photo = photos[indexPath.row]
			do {
				try realm.write({
					realm.delete(photo)
				})
			} catch {
				print(error.localizedDescription)
			}
		}
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
}
