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
				case presentErrorAlert
			}
		}
		struct ViewModel {
			enum ViewModelData {
				case displayErrorAlert
			}
		}
	}
	
}
