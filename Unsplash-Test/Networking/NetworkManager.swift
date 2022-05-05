//
//  NetworkManager.swift
//  Unsplash-Test
//
//  Created by mogggiii on 01.05.2022.
//

import Foundation

final class NetworkManager {
	
	static let shared = NetworkManager()
	
	private init() { }
	
	/// Getting random photos.
	/// - Parameters:
	/// - count: Number of photos in the response.
	/// - completion: The completion handler, where the result of the function is returned.
	func fetchRandomPhotos(count: Int, completion: @escaping (Result<[Photo], Error>) -> ()) {
		guard let url = APIUrls.randomPhotos(count: count).url else { return }
		let request = RequestManager.shared.getRequest(url: url, httpMethod: .get)
		DataTaskManager.shared.dataTask(request: request, completion: completion)
	}
	
	/// Retrieve the result of the search of photos by the specified parameters.
	/// - Parameters:
	/// - searchTerm: Search queries.
	/// - count: Number of photos in the response.
	/// - completion: The completion handler, where the result of the function is returned.
	func searchPhotos(count: Int, searchTerm: String, completion: @escaping (Result<SearchPhotoModel?, Error>) -> ()) {
		guard let url = APIUrls.searchPhotos(query: searchTerm, count: count).url else { return }
		let request = RequestManager.shared.getRequest(url: url, httpMethod: .get)
		DataTaskManager.shared.dataTask(request: request, completion: completion)
	}
	
}
