//
//  FebonachiCoordinator.swift
//  InfinityNumbers
//
// 
//

import UIKit

protocol FebonachiCoordinatorProtocol: Coordinator {
    func showSelfModule() -> UIViewController
}
 
final class FebonachiCoordinator: FebonachiCoordinatorProtocol {
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .main
        
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {}
    
    func showSelfModule() -> UIViewController {
        return madulesFactory.makeFebonachiFactory().viewController
    }
}

extension FebonachiCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != type })
    }
}
