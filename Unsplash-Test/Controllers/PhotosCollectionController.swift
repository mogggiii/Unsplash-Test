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
		collectionView.showsVerticalScrollIndicator = false
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: cellId)
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(collectionView)
		
		searchBarConfigure()
	}
	
	private func searchBarConfigure() {
		searchConroller.searchBar.placeholder = "Search photo"
		searchConroller.obscuresBackgroundDuringPresentation = false
		searchConroller.searchBar.delegate = self
		navigationItem.hidesSearchBarWhenScrolling = false
		self.navigationItem.searchController = searchConroller
	}

}

extension PhotosCollectionController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text else { return }
		
		searchBar.resignFirstResponder()
		print(text)
	}
}

extension PhotosCollectionController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell1 = UICollectionViewCell()
		cell1.backgroundColor = .gray
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotosCell else {
			return cell1
		}
		
		return cell
	}
}

extension PhotosCollectionController: WaterFallFlowLayoutDelegate {
	func waterFallFlowLayout(_ waterFallFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat {
		return 150
	}
	
	func columnOfWaterFallFlow(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	
}
