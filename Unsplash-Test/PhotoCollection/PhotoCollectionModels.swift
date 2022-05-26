//
//  PhotoCollectionModels.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum PhotoCollection {
	
	enum Model {
		struct Request {
			enum RequestType {
				case fetchRandomImages
				case fetchSearchImages(seatchTerm: String)
			}
		}
		struct Response {
			enum ResponseType {
				case presentRandomImages(searchResponse: [Photo])
				case presentSearchImages(searchResponse: SearchPhotoModel?)
				case presentErrorAlert
			}
		}
		struct ViewModel {
			enum ViewModelData {
				case displayRandomImages(viewModel: ImagesViewModel)
				case displaySearchImages(viewModel: ImagesViewModel)
				case displayErrorAlert
			}
		}
	}
	
}

struct ImagesViewModel {
	struct Cell {
		var createdDate: Date
		var likes: Int
		var width, height: Int
		var url: String
		var username: String
		var location: String?
	}
	
	let cells: [Cell]
}
