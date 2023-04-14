import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.animals) { animal in
                NavigationLink(destination: AnimalDetailView(animal: animal)) {
                    HStack {
                        Text(animal.name)
                    }
                }
            }
            .navigationTitle("Животные")
            .onAppear {
                viewModel.fetchAnimals()
            }
            .overlay(Group {
                if viewModel.isLoading {
                    ProgressView("Загрузка...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack {
                        Text(errorMessage)
                        Button("Обновить", action: viewModel.fetchAnimals)
                    }
                }
            })
        }
    }
}

struct AnimalDetailView: View {
    @EnvironmentObject var viewModel: ViewModel
    let animal: Animal

    var body: some View {
    ScrollView {
        VStack {
            ForEach(animal.breeds, id: \.name) { bread in
                AsyncImage(url: URL(string: bread.url), placeholder: {
                    Text(verbatim: "Loading...")
                })
                .scaledToFit()
                .frame(height: 200)
                Text(bread.name)
                    .font(.largeTitle)
                Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel(service: UnstableNetworkService()))
    }
}
