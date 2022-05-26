//
//  PhotoCollectionViewController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//

import UIKit

protocol PhotoCollectionDisplayLogic: AnyObject {
	func displayData(viewModel: PhotoCollection.Model.ViewModel.ViewModelData)
}

class PhotoCollectionViewController: UICollectionViewController, PhotoCollectionDisplayLogic {
	
	private let cellId = "cell"
	private let margin: CGFloat = 10.0
	private let searchConroller = UISearchController(searchResultsController: nil)
	private var viewModel = ImagesViewModel.init(cells: [])
	
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
		
		searchBarConfigure()
		setupCollectionView()
		fetchRandomImages()
	}
	
	func displayData(viewModel: PhotoCollection.Model.ViewModel.ViewModelData) {
		switch viewModel {
		// Dispaly Random Images
		case .displayRandomImages(let viewModel):
			self.viewModel = viewModel
			self.collectionView.reloadData()
		// Display Search Images
		case .displaySearchImages(let viewModel):
			self.viewModel = viewModel
			self.collectionView.reloadData()
		// Display Error Alert
		case .displayErrorAlert:
			self.showErrotAlert()
		}
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
	
	fileprivate func showErrotAlert() {
		let alert = UIAlertController(title: "Ooops", message: "Something went wrong", preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .destructive)
		
		alert.addAction(action)
		present(alert, animated: true)
	}
	
	fileprivate func searchBarConfigure() {
		searchConroller.searchBar.placeholder = "Search photo"
		searchConroller.obscuresBackgroundDuringPresentation = false
		searchConroller.searchBar.delegate = self
		navigationItem.hidesSearchBarWhenScrolling = false
		self.navigationItem.searchController = searchConroller
	}
	
	// MARK: - CollectionView Data Source
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return viewModel.cells.count
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? PhotosCell else {
			return UICollectionViewCell()
		}
		
		let image = viewModel.cells[indexPath.item]
		cell.image = image
		return cell
	}
	
}

// MARK: - Search Bar Delegate

extension PhotoCollectionViewController: UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text, !text.isEmpty else { return }
		searchBar.resignFirstResponder()
		
		interactor?.makeRequest(request: .fetchSearchImages(seatchTerm: text))
	}
}

// MARK: - WaterFallFlowLayoutDelegate

extension PhotoCollectionViewController: WaterFallFlowLayoutDelegate {
	func waterFallFlowLayout(_ waterFallFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat {
		let image = viewModel.cells[indexPath.item]
		let imageWidth = waterFallFlowLayout.itemWidth
		let imageHeight = CGFloat(image.height) * imageWidth / CGFloat(image.width)
		
		return imageHeight
	}
	
	func columnOfWaterFallFlow(in collectionView: UICollectionView) -> Int {
		return 2
	}
	
}
