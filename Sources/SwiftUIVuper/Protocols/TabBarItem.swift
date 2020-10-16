//
//  TabBarItem.swift
//  FilmsAppSUI
//
//  Created by Виталий Баник on 10.10.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import UIKit

// MARK: - TabBarItem
open protocol TabBarItem: CaseIterable {
    
    open var title: String { get }
    open var image: UIImage? { get }
    open var selectedImage: UIImage? { get }
    open var controller: UIViewController? { get }
    open var tabIndex: Int { get }
}
