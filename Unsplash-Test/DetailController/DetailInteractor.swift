//
//  DetailInteractor.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol DetailBusinessLogic {
  func makeRequest(request: Detail.Model.Request.RequestType)
}

class DetailInteractor: DetailBusinessLogic {

  var presenter: DetailPresentationLogic?
  var service: DetailService?
  
  func makeRequest(request: Detail.Model.Request.RequestType) {
    if service == nil {
      service = DetailService()
    }
  }
  
}
