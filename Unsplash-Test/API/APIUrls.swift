//
//  APIUrls.swift
//  Unsplash-Test
//
//  Created by mogggiii on 01.05.2022.
//

import Foundation

enum APIUrls {
	case randomPhotos(count: Int)
	case searchPhotos(query: String, count: Int)
	
	var url: URL? {
		let baseURL = APIConstant.baseURL
		
		switch self {
		/// generate url for random photos
		case .randomPhotos(let count):
			let stringURL = baseURL + "/photos/random?count=\(count)"
			return URL(string: stringURL)
		/// generate url for search term
		case let .searchPhotos(query, count):
			let stringURL = baseURL + "/search/photos?query=\(query)&order_by=relevant&per_page=\(count)"
			return URL(string: stringURL.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? "")
		}
	}
}


