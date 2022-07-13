//
//  AppCoordinator.swift
//  InfinityNumbers
//
//  
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType = .app
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        startMainMudule()
    }
    
    private func startMainMudule() {
        let simpleModule = showSimpleModile()
        simpleModule.tabBarItem.title = "Simple"
        
        let febonachiModule = showFebonachiModule()
        febonachiModule.tabBarItem.title = "Febonachi"
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [simpleModule, febonachiModule]
        
        navigationController.pushViewController(tabBarController, animated: true)
    }
    
    private func showFebonachiModule() -> UIViewController {
        let febonachiCoordinator = FebonachiCoordinator(navigationController)
        febonachiCoordinator.finishDelegate = self
        childCoordinators.append(febonachiCoordinator)
        return febonachiCoordinator.showSelfModule()
    }
    
    private func showSimpleModile() -> UIViewController {
        let simpleCoordinator = SimpleCoordinator(navigationController)
        simpleCoordinator.finishDelegate = self
        childCoordinators.append(simpleCoordinator)
        return simpleCoordinator.showSelfModule()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != type })
    }
}
