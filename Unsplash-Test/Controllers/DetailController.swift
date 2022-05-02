//
//  DetailController.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit

class DetailController: UIViewController {
	
	var photo: PhotoData?
	
	override func loadView() {
		super.loadView()

		self.view = DetailView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view().photo = photo
	}
	
	
	func view() -> DetailView {
		return self.view as! DetailView
	}
	
	/*
	 // MARK: - Navigation
	 
	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	 // Get the new view controller using segue.destination.
	 // Pass the selected object to the new view controller.
	 }
	 */
	
}
