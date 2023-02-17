import SwiftUI

struct TabBarView<TabBarRouter: Router>: View where TabBarRouter.Route == TabBarRoute {
    let router: TabBarRouter
    @State private var tabSelection = 2
    
    var body: some View {
        TabView(selection: $tabSelection) {
            router.viewFor(route: .mainView) {
                MainView(router: MainRouter())
            }
            .tabItem {
                Label("Main", systemImage: "list.dash")
                Text("Tab 1")
            }.tag(0)
            
            router.viewFor(route: .catalog) {
                Catalog()
            }
            .tabItem {
                Label("Catalog", systemImage: "book")
                Text("Tab 2")
            }.tag(1)
            
            router.viewFor(route: .loginView(data: "Login")) {
                LoginView(tabSelection: 2, text: "Login")
            }
            .tabItem {
                Label("Login", systemImage: "square.and.pencil")
                Text("Tab 3")
            }.tag(2)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(router: TabBarRouter())
    }
}

