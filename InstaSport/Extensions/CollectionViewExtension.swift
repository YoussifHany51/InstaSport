//
//  TableViewExtension.swift
//  InstaSport
//
//  Created by zyad Baset on 16/08/2024.
//

import Foundation
import UIKit
extension  UICollectionView {
    
    func RegisterNib<cell : UICollectionViewCell>(cell : cell.Type){
        
        let nibName = String(describing : cell.self)
        
        self.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }

    func deque<cell : UICollectionViewCell>(cell:cell.Type) -> cell{
        let identifier = String(describing: cell.self)
        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? cell else {
            fatalError("error in cell")
        }
        return cell
    }
}
