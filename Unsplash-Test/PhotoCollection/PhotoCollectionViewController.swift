//
//  PhotoCollectionViewController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotoCollectionDisplayLogic: AnyObject {
	func displayData(viewModel: PhotoCollection.Model.ViewModel.ViewModelData)
}

class PhotoCollectionViewController: UICollectionViewController, PhotoCollectionDisplayLogic {
	
	private let cellId = "cell"
	private let margin: CGFloat = 10.0
	private let searchConroller = UISearchController(searchResultsController: nil)
	private var images = [Photo]()
	
	var interactor: PhotoCollectionBusinessLogic?
	var router: (NSObjectProtocol & PhotoCollectionRoutingLogic)?
	
	private lazy var layout: WaterFallFlowLayout = {
		let layout = WaterFallFlowLayout()
		layout.delegate = self
		layout.minimumLineSpacing = 10
		layout.minimumInteritemSpacing = 10
		layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
		return layout
	}()
	
	// MARK: Object lifecycle
	
	init() {
		let layout = WaterFallFlowLayout()
		super.init(collectionViewLayout: layout)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	// MARK: Setup
	
	private func setup() {
		let viewController        = self
		let interactor            = PhotoCollectionInteractor()
		let presenter             = PhotoCollectionPresenter()
		let router                = PhotoCollectionRouter()
		viewController.interactor = interactor
		viewController.router     = router
		interactor.presenter      = presenter
		presenter.viewController  = viewController
		router.viewController     = viewController
	}
	
	// MARK: Routing
	
	
	
	// MARK: View lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
		fetchRandomImages()
	}
	
	func displayData(viewModel: PhotoCollection.Model.ViewModel.ViewModelData) {
		
	}
	
	/// Setup CollectionView
	/// - Register cell
	/// - Sets custom layout
	fileprivate func setupCollectionView() {
		collectionView.collectionViewLayout = layout
		collectionView.showsVerticalScrollIndicator = false
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: cellId)
	}
	
	fileprivate func fetchRandomImages() {
		interactor?.makeRequest(request: .fetchRandomImages)
	}
	// MARK: - CollectionView Data Source
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 10
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotosCell else {
			return UICollectionViewCell()
		}
		
//		let photo = images[indexPath.item]
//		cell.photo = photo
		return cell
	}
}

extension PhotoCollectionViewController: WaterFallFlowLayoutDelegate {
	func waterFallFlowLayout(_ waterFallFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat {
//		let image = images[indexPath.item]
//		let imageWidth = waterFallFlowLayout.itemWidth
//		let imageHeight = CGFloat(image.height) * imageWidth / CGFloat(image.width)
//
//		return imageHeight
		
		return 250
	}
	
	func columnOfWaterFallFlow(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
	
}
