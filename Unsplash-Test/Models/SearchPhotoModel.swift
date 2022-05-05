//
//  SearchPhotoModel.swift
//  Unsplash-Test
//
//  Created by mogggiii on 02.05.2022.
//

import Foundation

struct SearchPhotoModel: Decodable {
	let total: Int
	let results: [Photo]
}

struct Photo: Decodable {
	let id: String
	let createdAt: Date
	let width, height: Int
	let urls: Urls
	let likes: Int
	let likedByUser: Bool
	var isFavoritePhoto = false
	let user: User
	
	enum CodingKeys: String, CodingKey {
		case id
		case createdAt = "created_at"
		case width, height, urls, likes
		case likedByUser = "liked_by_user"
		case user
	}
	
	/// Leads to FavoritePhotos
	func toFavoritePhotoModel() -> FavoritePhotos {
		let favPhoto = FavoritePhotos()
		let df = DateFormatter()
		favPhoto.userName = self.user.username
		favPhoto.isFavourite = self.isFavoritePhoto
		favPhoto.createdAT = df.format().string(from: self.createdAt)
		favPhoto.photoUrl = self.urls.regular
		favPhoto.location = self.user.location
		favPhoto.likesCount = self.likes
		return favPhoto
	}
}

struct Urls: Decodable {
	let raw, full, regular, small: String
	let thumb, smallS3: String
	
	enum CodingKeys: String, CodingKey {
		case raw, full, regular, small, thumb
		case smallS3 = "small_s3"
	}
}

struct User: Decodable {
	let username: String
	let location: String?
}


