//
//  CardsGridViewFlowLayout.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class CardsGridViewFlowLayout: UICollectionViewFlowLayout {
    
    let cellSize: CGSize
    let minimumMargin: CGFloat
    let headerHeight: CGFloat
    
    required init(cellSize: CGSize = CGSize(width: 85.0, height: 118.0),
                  minimumMargin: CGFloat = 16.0,
                  scrollDirection: UICollectionView.ScrollDirection = .vertical,
                  headerHeight: CGFloat = 82.0) {
        self.cellSize = cellSize
        self.minimumMargin = minimumMargin
        self.headerHeight = headerHeight
        super.init()
        self.scrollDirection = scrollDirection
        self.itemSize = cellSize
    }
    
    private func setLayout() {
        let margin = marginFor(frame: collectionView?.frame ?? .zero)
        self.minimumInteritemSpacing = margin
        self.minimumLineSpacing = margin
        self.headerReferenceSize = CGSize(width: collectionView?.frame.width ?? 0, height: self.headerHeight)
    }
    
    func marginFor(frame: CGRect) -> CGFloat {
        let totalWidth = frame.width
        var numberOfCells = (totalWidth / cellSize.width).rounded(.down)
        
        while numberOfCells > 1 {
            if (numberOfCells * cellSize.width) + ((numberOfCells + 1) * minimumMargin) > totalWidth {
                numberOfCells -= 1
            } else {
                let totalMargin = totalWidth - (numberOfCells * cellSize.width)
                return (totalMargin / (numberOfCells + 1))
            }
        }
        let totalMargin = totalWidth - cellSize.width
        return (totalMargin / 2)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.setLayout()
    }
    
}
