//
//  Presenter.swift
//  FilmsAppSUI
//
//  Created by Виталий Баник on 10.10.2020.
//  Copyright © 2020 Виталий Баник. All rights reserved.
//

import SwiftUI

// MARK: - Presenter
public protocol Presenter: ObservableObject {
    
    var container: Container? { get set }
    
    func onClickError()
}

public extension Presenter {
    
    func onClickError() {}
}
