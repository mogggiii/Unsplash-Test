//
//  DetailPresenter.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailPresentationLogic {
  func presentData(response: Detail.Model.Response.ResponseType)
}

class DetailPresenter: DetailPresentationLogic {
  weak var viewController: DetailDisplayLogic?
  
  func presentData(response: Detail.Model.Response.ResponseType) {
  
  }
  
}
