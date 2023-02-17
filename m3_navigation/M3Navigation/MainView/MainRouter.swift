import SwiftUI

enum MainRoute {
    case loginView(data: String)
}

struct MainRouter: Router {
  typealias Route = MainRoute
  var usingNavigation = true
  
  func viewFor<T>(route: MainRoute, content: () -> T) -> AnyView where T : View {
    switch route {
    case let .loginView(data):
      if usingNavigation {
          return AnyView(NavigationLink(destination: LoginView(tabSelection: 2, text: data)) {
          content()
        })
      } else {
        return AnyView(Button(action: { }) {
          content()
        })
      }
    }
  }
}

