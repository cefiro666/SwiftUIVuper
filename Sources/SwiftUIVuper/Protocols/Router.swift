//
//  Router.swift
//  FilmsAppSUI
//
//  Created by Виталий Баник on 10.10.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import UIKit
import SwiftUI

open typealias Contentable = View & Configurable & Presentable

// MARK: - Router
open protocol Router {
    
    open var window: UIWindow? { get }
    open var rootController: UIViewController? { get }
    open var navigationController: UINavigationController? { get }
    open var tabBarController: UITabBarController? { get }
    open var presentedController: UIViewController? { get }
    
    @discardableResult open func pushScreen<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    @discardableResult open func pushScreenWithHidenTabBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    @discardableResult open func presentScreenWithNavBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    @discardableResult open func presentScreen<Content: Contentable>(
        view: Content.Type,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    @discardableResult open func getScreenWithNavBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    @discardableResult open func getScreen<Content: Contentable>(
        view: Content.Type,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    @discardableResult open func setRootScreenWithNavBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    @discardableResult open func setRootScreen<Content: Contentable>(
        view: Content.Type,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController?
    
    open func popScreen()
    open func dismissScreen(completion: (() -> ())?)
    open func setTab<Item: TabBarItem & CaseIterable>(_ tab: Item)
}

// MARK: - Router default implementation
open extension Router {

// MARK: - Properties
    open var window: UIWindow? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }
    
    open var rootController: UIViewController? {
        return self.window?.rootViewController
    }
    
    open var navigationController: UINavigationController? {
        let navigationController = (self.rootController as? UINavigationController) ??
            (self.tabBarController?.selectedViewController as? UINavigationController) ??
            (self.rootController?.presentedViewController as? UINavigationController)
            
        return navigationController
    }
    
    open var tabBarController: UITabBarController? {
        return (self.rootController as? UITabBarController) ?? self.rootController?.tabBarController
    }
    
    open var presentedController: UIViewController? {
        return self.rootController?.presentedViewController ?? self.rootController
    }
    
// MARK: - Methods
    @discardableResult open func pushScreen<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        let viewController = view.configurator.createScreen(configureBlock: configureBlock)
        viewController.title = title
        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }
    
    @discardableResult open func pushScreenWithHidenTabBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        let viewController = view.configurator.createScreen(configureBlock: configureBlock)
        viewController.title = title
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
        return viewController
    }
    
    @discardableResult open func presentScreenWithNavBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        let viewController = view.configurator.createScreen(configureBlock: configureBlock)
        viewController.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.rootController?.present(navigationController, animated: true)
        return navigationController
    }
    
    @discardableResult open func presentScreen<Content: Contentable>(
        view: Content.Type,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        let viewController = view.configurator.createScreen(configureBlock: configureBlock)
        viewController.modalPresentationStyle = .fullScreen
        self.rootController?.present(viewController, animated: true)
        return viewController
    }
    
    @discardableResult open func getScreenWithNavBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        let viewController = view.configurator.createScreen(configureBlock: configureBlock)
        viewController.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
    
    @discardableResult open func getScreen<Content: Contentable>(
        view: Content.Type,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        return view.configurator.createScreen(configureBlock: configureBlock)
    }
    
    @discardableResult open func setRootScreenWithNavBar<Content: Contentable>(
        view: Content.Type,
        title: String,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        let viewController = view.configurator.createScreen(configureBlock: configureBlock)
        viewController.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = navigationController
        return navigationController
    }
    
    @discardableResult open func setRootScreen<Content: Contentable>(
        view: Content.Type,
        configureBlock: ((Content.ConfiguratorType.Content?) -> ())?
    ) -> UIViewController? {
        
        let viewController = view.configurator.createScreen(configureBlock: configureBlock)
        self.window?.rootViewController = viewController
        return viewController
    }
    
    open func popScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    open func dismissScreen(completion: (() -> ())? = nil) {
        self.presentedController?.dismiss(animated: true, completion: completion)
    }
    
    open func setTab<Item: TabBarItem & CaseIterable>(_ tab: Item) {
        self.tabBarController?.selectedIndex = tab.tabIndex
    }
    
}
