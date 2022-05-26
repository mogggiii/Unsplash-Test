//
//  PhotoCollectionInteractor.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PhotoCollectionBusinessLogic {
  func makeRequest(request: PhotoCollection.Model.Request.RequestType)
}

class PhotoCollectionInteractor: PhotoCollectionBusinessLogic {

  var presenter: PhotoCollectionPresentationLogic?
  var service: PhotoCollectionService?
  
  func makeRequest(request: PhotoCollection.Model.Request.RequestType) {
    if service == nil {
      service = PhotoCollectionService()
    }
		
		switch request {
		case .fetchRandomImages:
			self.service?.fetchRandomPhotos(count: 50, completion: { [weak self] result in
				switch result {
				case .success(let searchResponse):
					print("COUNT", searchResponse.count)
					self?.presenter?.presentData(response: .presentRandomImages(searchResponse: searchResponse))
				case .failure(let error):
					print("Error to fetch random images", error)
					self?.presenter?.presentData(response: .presentErrorAlert)
				}
			})
		case .fetchSearchImages(let searchTerm):
			self.service?.searchPhotos(count: 50, searchTerm: searchTerm, completion: { [weak self] result in
				switch result {
				case .success(let response):
					self?.presenter?.presentData(response: .presentSearchImages(searchResponse: response))
				case .failure(let error):
					print("Error to fetch search images", error)
					self?.presenter?.presentData(response: .presentErrorAlert)
				}
			})
		}
  }
  
}
