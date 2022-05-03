//
//  PhotosCollectionController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit

class PhotosCollectionController: UIViewController {
	
	private let cellId = "cellId"
	private let margin: CGFloat = 10.0
	private let searchConroller = UISearchController(searchResultsController: nil)
	private var images = [PhotoData]()
	
	private let activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView()
		indicator.style = .medium
		return indicator
	}()
	
	private lazy var layout: WaterFallFlowLayout = {
		let layout = WaterFallFlowLayout()
		layout.delegate = self
		layout.minimumLineSpacing = 10
		layout.minimumInteritemSpacing = 10
		layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
		return layout
	}()
	
	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.showsVerticalScrollIndicator = false
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: cellId)
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(collectionView)
		
		getRandomPhotos()
		searchBarConfigure()
		loading()
	}
	
	fileprivate func searchBarConfigure() {
		searchConroller.searchBar.placeholder = "Search photo"
		searchConroller.obscuresBackgroundDuringPresentation = false
		searchConroller.searchBar.delegate = self
		navigationItem.hidesSearchBarWhenScrolling = false
		self.navigationItem.searchController = searchConroller
	}
	
	fileprivate func getRandomPhotos() {
		NetworkManager.shared.fetchRandomPhotos(count: 50) { [weak self] result in
			switch result {
			case .success(let photos):
				self?.images = photos
				DispatchQueue.main.async {
					self?.collectionView.reloadData()
				}
			case.failure(let error):
				print("FFFFF", error.localizedDescription)
			}
			
			self?.activityIndicator.stopAnimating()
		}
	}
	
	fileprivate func loading() {
		view.addSubview(activityIndicator)
		view.bringSubviewToFront(activityIndicator)
		activityIndicator.frame = view.bounds
		activityIndicator.startAnimating()
		activityIndicator.hidesWhenStopped = true
	}
	
}

extension PhotosCollectionController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text, !text.isEmpty else { return }
		
		NetworkManager.shared.searchPhotos(count: 30, searchTerm: text) { result in
			switch result {
			case .success(let requestResult):
				guard let photos = requestResult?.results else { return }
				self.images = photos
				DispatchQueue.main.async {
					self.collectionView.reloadData()
				}
			case .failure(let error):
				print(error)
			}
		}
		searchBar.resignFirstResponder()
		print(text)
	}
}

extension PhotosCollectionController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
		
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotosCell else {
			return UICollectionViewCell()
		}
		
		let photo = images[indexPath.item]
		cell.photo = photo
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let photo = images[indexPath.item]
		let detailVC = DetailController()
		detailVC.photo = photo
		navigationController?.pushViewController(detailVC, animated: true)
	}
}

extension PhotosCollectionController: WaterFallFlowLayoutDelegate {
	func waterFallFlowLayout(_ waterFallFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat {
		let image = images[indexPath.item]
		
		let imageWidth = waterFallFlowLayout.itemWidth
		let imageHeight = CGFloat(image.height) * imageWidth / CGFloat(image.width)
		
		return imageHeight
	}
	
	func columnOfWaterFallFlow(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	
}
