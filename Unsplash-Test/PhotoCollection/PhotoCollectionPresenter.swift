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

  }
  
}
