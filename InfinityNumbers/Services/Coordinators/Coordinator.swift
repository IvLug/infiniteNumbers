//
//  Coordinator.swift
//  InfinityNumbers
//
//  
//

import UIKit

protocol CoordinatorFinishDelegate {
    func coordinatorDidFinish(_ childCoordinator: Coordinator)
}

protocol Coordinator: AnyObject {
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    var type: CoordinatorType { get }
    func start()
    func finish()
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    
    var madulesFactory: ModulesFactoryProtocol {
        ModulesFactory()
    }
    
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(self)
    }
}

enum CoordinatorType {
    case app, main
}
