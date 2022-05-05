//
//  RequestManager.swift
//  Unsplash-Test
//
//  Created by mogggiii on 02.05.2022.
//

import Foundation

final class RequestManager {
	
	static let shared = RequestManager()
	
	private init() { }
	
	/// Getting a URLRequest with the passed parameters and authorization data.
	/// - Parameters:
	/// - url: URL of the request.
	/// - httpMethod: HTTP request method.
	func getRequest(url: URL, httpMethod: HTTPMethod) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue
		request.addValue("Client-ID \(APIConstant.accessKey)", forHTTPHeaderField: "Authorization")
		return request
	}
}

/// http methods
enum HTTPMethod: String{
	case get = "GET"
	case post = "POST"
}
