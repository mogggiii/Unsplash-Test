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
	
	func fetchRandomPhotos(count: Int, completion: @escaping (Result<[PhotoData], Error>) -> ()) {
		guard let url = APIUrls.randomPhotos(count: count).url else { return }
		let request = RequestManager.shared.getRequest(url: url, httpMethod: .get)
		DataTaskManager.shared.dataTask(request: request, completion: completion)
	}
	
	func searchPhotos(count: Int, searchTerm: String, completion: @escaping (Result<RequestResults?, Error>) -> ()) {
		guard let url = APIUrls.searchPhotos(query: searchTerm, count: count).url else { return }
		let request = RequestManager.shared.getRequest(url: url, httpMethod: .get)
		DataTaskManager.shared.dataTask(request: request, completion: completion)
	}
		
}
