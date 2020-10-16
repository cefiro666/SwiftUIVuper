//
//  Presentable.swift
//  FilmsAppSUI
//
//  Created by Виталий Баник on 10.10.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import Foundation

// MARK: - Presentable
open protocol Presentable {
    open associatedtype PresenterType: Presenter
    
    open var presenter: PresenterType { get }
}
