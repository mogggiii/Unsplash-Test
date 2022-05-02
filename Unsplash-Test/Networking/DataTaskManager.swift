//
//  DataTaskManager.swift
//  Unsplash-Test
//
//  Created by mogggiii on 02.05.2022.
//

import Foundation

final class DataTaskManager {
	
	static let shared = DataTaskManager()
	
	private init() { }
	
	func dataTask<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, Error>) -> ()) {
		URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				print("Error: -- -- -- ")
				completion(.failure(error))
				return
			}
			
			guard let data = data,
						let response = response as? HTTPURLResponse
			else { return }
			
			print("Status code", response.statusCode)
			
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = .iso8601
			
			do {
				let result = try decoder.decode(T.self, from: data)
				DispatchQueue.main.async {
					completion(.success(result))
				}
				print(result)
				
			} catch let error {
				print("Decoding error", error)
				completion(.failure(error))
			}
			
		} .resume()
	}
	
}
