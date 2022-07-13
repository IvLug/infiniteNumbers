//
//  NumbersLayout.swift
//  InfinityNumbers
//
//
//

import UIKit

class NumbersLayout: UICollectionViewFlowLayout {
    
    private let itemsSectionInset: CGFloat = 0
    
    override init() {
        super.init()
        scrollDirection = .vertical
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        let itemWidth = (UIScreen.main.bounds.width / 2) - (itemsSectionInset * 2)
        let itemHeight = itemWidth
        
        itemSize = CGSize(width: itemWidth, height: itemHeight)
        sectionInset = UIEdgeInsets(
            top: itemsSectionInset,
            left: itemsSectionInset,
            bottom: itemsSectionInset,
            right: itemsSectionInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
