//
//  ModulesFactory.swift
//  InfinityNumbers
//
// 
//

import UIKit

protocol ModulesFactoryProtocol {
    var di: DIProtocol { get }
    func makeSimpleModuleFactory() -> AppModule<SimpleiViewController, SimpleViewModel>
    func makeFebonachiFactory() -> AppModule<FebonachiViewController, FebonachiViewModel>
}

final class ModulesFactory: ModulesFactoryProtocol {
    
    var di: DIProtocol
    
    init() {
        self.di = DI()
    }
    
     func makeFebonachiFactory() -> AppModule<FebonachiViewController, FebonachiViewModel> {
        let viewModel = FebonachiViewModel(di: di)
        let viewController = FebonachiViewController(viewModel: viewModel)
        let appModule = AppModule(viewController: viewController, viewModel: viewModel)
        return appModule
    }
    
     func makeSimpleModuleFactory() -> AppModule<SimpleiViewController, SimpleViewModel> {
        let viewModel = SimpleViewModel(di: di)
        let viewController = SimpleiViewController(viewModel: viewModel)
        let appMadule = AppModule(viewController: viewController, viewModel: viewModel)
        return appMadule
    }
}
