//
//  AppModuleModel.swift
//  InfinityNumbers
//
//  
//

import UIKit

struct AppModule<V: UIViewController, U: AnyObject> {
    let viewController: V
    let viewModel: U
}
