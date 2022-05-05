//
//  MainTabBarController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewControllers = [
			createViewController(viewController: PhotosCollectionController(),
													 title: "Photo",
													 image: "photo.circle"),
			
			createViewController(viewController: LikedPhotoController(),
													 title: "Liked",
													 image: "heart.fill"),
		]
	}
	
	/// Generate navigation view controller
	fileprivate func createViewController(viewController: UIViewController, title: String, image: String) -> UIViewController {
		let navVC = UINavigationController(rootViewController: viewController)
		navVC.navigationBar.prefersLargeTitles = true
		navVC.tabBarItem.title = title
		navVC.tabBarItem.image = UIImage(systemName: image)
		
		viewController.navigationItem.title = title
		
		return navVC
		
	}
}
