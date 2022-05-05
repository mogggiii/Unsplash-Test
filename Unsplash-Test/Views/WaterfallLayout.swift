//
//  WaterfallLayout.swift
//  Unsplash-Test
//
//  Created by mogggiii on 29.04.2022.
//

import UIKit

protocol WaterFallFlowLayoutDelegate: NSObjectProtocol {
	func waterFallFlowLayout(_ waterFallFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat
	func columnOfWaterFallFlow(in collectionView: UICollectionView) -> Int
}

class WaterFallFlowLayout: UICollectionViewFlowLayout {
	
	weak var delegate: WaterFallFlowLayoutDelegate?
	
	var itemWidth: CGFloat = 10.0
	
	fileprivate let defaultColumn = 2
	
	fileprivate var columns: Int {
		guard let collectionView = collectionView else { return defaultColumn }
		return delegate?.columnOfWaterFallFlow(in: collectionView) ?? defaultColumn
	}
	
	fileprivate lazy var layoutAttributes: [UICollectionViewLayoutAttributes] = []
	fileprivate lazy var heights: [CGFloat] = Array(repeating: self.sectionInset.top, count: columns)
	fileprivate lazy var maxHeight: CGFloat = 0.0
	
	override func prepare() {
		super.prepare()
		
		layoutAttributes = []
		heights = Array(repeating: self.sectionInset.top, count: columns)
		
		guard let collectionView = collectionView else { return }
		
		let itemWidth = (collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(columns - 1)) / CGFloat(columns)
		self.itemWidth = itemWidth
		let itemCount = collectionView.numberOfItems(inSection: 0)
		var minHeightIndex = 0
		
		for i in layoutAttributes.count ..< itemCount {
			let indexPath = IndexPath(item: i, section: 0)
			let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
			let itemHeight = delegate?.waterFallFlowLayout(self, itemHeight: indexPath)
			
			if let value = heights.min() {
				minHeightIndex = heights.firstIndex(of: value) ?? 0
			}
			
			var itemmY = heights[minHeightIndex]
			if i >= columns {
				itemmY += minimumLineSpacing
			}
			
			let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
			attributes.frame = CGRect(x: itemX, y: itemmY, width: itemWidth, height: CGFloat(itemHeight ?? 0.0))
			layoutAttributes.append(attributes)
			heights[minHeightIndex] = attributes.frame.maxY
		}
		
		maxHeight = heights.max() ?? 0 + sectionInset.bottom
	}
}

extension WaterFallFlowLayout {
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return layoutAttributes.filter { $0.frame.intersects(rect) }
	}
	
	override var collectionViewContentSize: CGSize {
		guard let collectionView = collectionView else { return .zero }
		return CGSize(width: collectionView.bounds.width, height: maxHeight)
	}
}
