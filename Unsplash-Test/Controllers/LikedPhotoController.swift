//
//  LikedPhotoController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit
import RealmSwift

class LikedPhotoController: UIViewController {
	
	let realm = try! Realm()
	var photos: Results<FavoritePhotos>!
	
	private let cellId = "cellId"
	private let alert = AlertView()
	
	// MARK: - UI Components
	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: view.bounds)
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(LikedPhotosCell.self, forCellReuseIdentifier: cellId)
		return tableView
	}()
	
	// MARK: - VC life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(handleDelete))
		
		view.addSubview(tableView)
		loadPhotos()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		loadPhotos()
	}
	
	/// Upload photos from Realm
	fileprivate func loadPhotos() {
		photos = realm.objects(FavoritePhotos.self)
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}
	
	// MARK: - Alerts
	fileprivate func showDeletedAlert() {
		addAlert()
		alert.isSaved = false
		alert.animate(view: self.view)
	}
	
	fileprivate func addAlert() {
		alert.frame = CGRect(x: 0, y: 0, width: view.frame.width / 2, height: view.frame.width / 2)
		alert.center = view.center
		alert.alpha = 0
		view.addSubview(alert)
		view.bringSubviewToFront(alert)
	}
	
	fileprivate func showErrorAlert() {
		let alert = UIAlertController(title: "Ooops", message: "Something went wrong", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .destructive)
		
		alert.addAction(action)
		present(alert, animated: true)
	}
	
	// MARK: - Objc fileprivate func
	@objc fileprivate func handleDelete() {
		/// delete all objects Realm
		do {
			try realm.write({
				realm.deleteAll()
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			})
		} catch {
			DispatchQueue.main.async {
				self.showErrorAlert()
			}
		}
	}
}
// MARK: - Table view data source, Table view delegate
extension LikedPhotoController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return photos.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? LikedPhotosCell else {
			return UITableViewCell()
		}
		
		let photo = photos[indexPath.row]
		cell.favPhoto = photo
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let favPhoto = photos[indexPath.row]
		let vc = DetailController()
		vc.favPhoto = favPhoto
		navigationController?.pushViewController(vc, animated: true)
	}
	
	func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .delete
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let photo = photos[indexPath.row]
			
			/// delete single object Realm
			do {
				try realm.write({
					realm.delete(photo)
					self.showDeletedAlert()
				})
			} catch {
				print(error.localizedDescription)
				self.showDeletedAlert()
			}
		}
		
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

}
