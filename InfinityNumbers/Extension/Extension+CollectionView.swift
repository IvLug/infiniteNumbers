//
//  Extension+CollectionView.swift
//  InfinityNumbers
//
//
//

import UIKit

extension UICollectionView {
    func registers<T: UICollectionViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: name))
    }
    
    func registers<T: UICollectionReusableView>(reusableViewWithClass name: T.Type, ofKind kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: name))
    }
    
    /// Переиспользование ячейки - let myCell: SomeMyCell = collectionView.dequeueCell(at: indexPath)
    /// - Parameters:
    ///   - indexPath: indexPath
    ///   - doError: показать ошибку или нет
    /// - Returns: Ячейку с указанным типом
    func dequeueCell<T: UICollectionViewCell>(at indexPath: IndexPath, doError: Bool = false) -> T {
        let id = String(describing: T.self)
        let temp = dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? T
        guard let cell = temp else {
            if doError { fatalError("Can't dequeue cell") }
            return T()
        }
        return cell
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(kind: String, for indexPath: IndexPath, doError: Bool = false) -> T {
        let id = String(describing: T.self)
        let temp = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: id, for: indexPath) as? T
        guard let view = temp else {
            if doError { fatalError("Can't dequeue UICollectionReusableView") }
            return T()
        }
        return view
    }
}
