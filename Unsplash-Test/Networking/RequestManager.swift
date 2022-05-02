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
	
	func getRequest(url: URL, httpMethod: HTTPMethod) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue
		request.addValue("Client-ID \(APIConstant.accessKey)", forHTTPHeaderField: "Authorization")
		return request
	}
}

enum HTTPMethod: String{
	case get = "GET"
	case post = "POST"
}
