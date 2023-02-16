import SwiftUI

struct MainView<MainRouter: Router>: View where MainRouter.Route == MainRoute {
    let router: MainRouter
    @State var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                    .padding()
                .navigationTitle("Main")
                
                router.viewFor(route: .loginView(data: "Login")) {
                    Text("переход на логин")
                }
            }
            .navigationBarItems(
                trailing:
                    Button(action: {showingSheet = true}) {
                        Image(systemName: "ellipsis")
                            .font(.largeTitle)
                    }
                    .foregroundColor(.blue)
                    .sheet(isPresented: $showingSheet) {
                        LoginView(tabSelection: Binding<Int>(get: { self.tabSelection }, set: { self.tabSelection = $0 }), text: "Login")
                    }
            )
        }
    }
}

struct LoginView: View {
@Binding var tabSelection: Int
    let text: String
    
  var body: some View {
      VStack {
          Text(text)
              .font(.title)
              .padding()
          Button("Login") {
              self.tabSelection = 0
          }
          .padding()
      }
  }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(router: MainRouter())
    }
}
