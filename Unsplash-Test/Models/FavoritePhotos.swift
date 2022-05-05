//
//  FavoritePhotos.swift
//  Unsplash-Test
//
//  Created by mogggiii on 02.05.2022.
//

import Foundation
import RealmSwift

class FavoritePhotos: Object {
	@objc dynamic var userName: String = ""
	@objc dynamic var createdAT: String = ""
	@objc dynamic var photoUrl: String = ""
	@objc dynamic var location: String? = ""
	@objc dynamic var likesCount = 0
	@objc dynamic var isFavourite: Bool = false
}
