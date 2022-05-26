//
//  PhotoCollectionPresenter.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotoCollectionPresentationLogic {
  func presentData(response: PhotoCollection.Model.Response.ResponseType)
}

class PhotoCollectionPresenter: PhotoCollectionPresentationLogic {
  
  weak var viewController: PhotoCollectionDisplayLogic?
  
  func presentData(response: PhotoCollection.Model.Response.ResponseType) {
		switch response {
		// Present Random Images
		case .presentRandomImages(let searchResponse):
			let cells = searchResponse.map { photo in
				cellViewModel(from: photo)
			}
			
			let imagesViewModel = ImagesViewModel.init(cells: cells)
			viewController?.displayData(viewModel: .displayRandomImages(viewModel: imagesViewModel))
		
		// Present Search Images
		case .presentSearchImages(searchResponse: let searchResponse):
			let cells = searchResponse?.results.map({ photo in
				cellViewModel(from: photo)
			}) ?? []
			
			let imagesViewModel = ImagesViewModel.init(cells: cells)
			viewController?.displayData(viewModel: .displaySearchImages(viewModel: imagesViewModel))
		
		// Present Error Alert
		case .presentErrorAlert:
			viewController?.displayData(viewModel: .displayErrorAlert)
		}
  }
	
	fileprivate func cellViewModel(from image: Photo) -> ImagesViewModel.Cell {
		return ImagesViewModel.Cell(
			createdDate: image.createdAt,
			likes: image.likes,
			width: image.width,
			height: image.height,
			url: image.urls.small,
			username: image.user.username,
			location: image.user.location)
	}
  
}
