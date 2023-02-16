//
//  TabBarRouter.swift
//  M3Navigation
//
//  Created by i0240 on 16.02.2023.
//

import SwiftUI

enum TabBarRoute {
    case mainView
    case catalog
    case loginView(data: String)
}

struct TabBarRouter: Router {
    typealias Route = TabBarRoute
    
    func viewFor<T>(route: TabBarRoute, content: () -> T) -> AnyView where T : View {
        switch route {
        case .mainView:
            return AnyView(content())
        case .catalog:
            return AnyView(content())
        case .loginView:
            return AnyView(content())
        }
    }
}
