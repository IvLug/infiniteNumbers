//
//  SimpleCoordinator.swift
//  InfinityNumbers
//
//  
//

import UIKit

protocol SimpleCoordinatorProtocol: Coordinator {
    func showSelfModule() -> UIViewController
}
 
final class SimpleCoordinator: SimpleCoordinatorProtocol {
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .main
        
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {}
    
    func showSelfModule() -> UIViewController {
        return madulesFactory.makeSimpleModuleFactory().viewController
    }
}

extension SimpleCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != type })
    }
}
