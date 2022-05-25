//
//  PhotoCollectionWorker.swift
//  Unsplash-Test
//
//  Created by mogggiii on 26.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class PhotoCollectionService {
	
	/// http methods
	fileprivate enum HTTPMethod: String {
		case get = "GET"
		case post = "POST"
	}
	
	/// Getting random photos.
	/// - Parameters:
	/// - count: Number of photos in the response.
	/// - completion: The completion handler, where the result of the function is returned.
	func fetchRandomPhotos(count: Int, completion: @escaping (Result<[Photo], Error>) -> ()) {
		guard let url = APIUrls.randomPhotos(count: count).url else { return }
		let request = self.getRequest(url: url, httpMethod: .get)
		self.dataTask(request: request, completion: completion)
	}
	
	/// Retrieve the result of the search of photos by the specified parameters.
	/// - Parameters:
	/// - searchTerm: Search queries.
	/// - count: Number of photos in the response.
	/// - completion: The completion handler, where the result of the function is returned.
	func searchPhotos(count: Int, searchTerm: String, completion: @escaping (Result<SearchPhotoModel?, Error>) -> ()) {
		guard let url = APIUrls.searchPhotos(query: searchTerm, count: count).url else { return }
		let request = self.getRequest(url: url, httpMethod: .get)
		self.dataTask(request: request, completion: completion)
	}
	
	/// Getting a URLRequest with the passed parameters and authorization data.
	/// - Parameters:
	/// - url: URL of the request.
	/// - httpMethod: HTTP request method.
	fileprivate func getRequest(url: URL, httpMethod: HTTPMethod) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue
		request.addValue("Client-ID \(APIConstant.accessKey)", forHTTPHeaderField: "Authorization")
		return request
	}
	
	/// Executing a URLSessionDataTask with the passed request.
	/// - Parameters:
	/// - request: Request required for execution.
	/// - completion: Completion handler, called after receiving data.
	fileprivate func dataTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> ()) {
		URLSession.shared.dataTask(with: request) { data, _, error in
			if let error = error {
				print("Data task error", error)
				return
			}
			
			guard let data = data else { return }
			
			/// Json decoder
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			
			do {
				let result = try decoder.decode(T.self, from: data)
				DispatchQueue.main.async {
					completion(.success(result))
				}
			} catch let error {
				print("Decoding error", error)
				completion(.failure(error))
			}
		} .resume()
	}
	
}
