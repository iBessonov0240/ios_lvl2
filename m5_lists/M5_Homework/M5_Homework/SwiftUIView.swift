import SwiftUI

struct SwiftUIView: View {
    @State private var selection = 0
    let data = DataAnimals()
    @State var isExpanded = false
    var columns: [GridItem] =
    [.init(.fixed(90))]

    var body: some View {
        TabView(selection: $selection) {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(data.animals) { animal in
                        Text(animal.name)
                            .font(.headline)
                            .foregroundColor(Color.blue)
                        HStack {
                            VStack(alignment: .leading) {
                                ForEach(animal.breeds, id: \.name) { bread in
                                    HStack {
                                        AsyncImage(url: URL(string: bread.url), placeholder: {
                                            Text(verbatim: "Loading...")
                                        })
                                        .frame(width: 200, height: 200)
                                        .clipShape(Circle())

                                        Text(bread.name)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .tabItem {
                VStack {
                    Image(systemName: "1.circle")
                    Text("LazyVStack")
                }
            }
            .tag(0)

            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading) {
                    LazyVStack(alignment: .leading) {
                        ForEach(data.animals) { animal in
                            Text(verbatim: animal.name)
                                .font(.headline)
                                .foregroundColor(Color.blue)
                            VStack(alignment: .center) {
                            ForEach(animal.breeds, id: \.name) { bread in
                                AsyncImage(url: URL(string: bread.url), placeholder: {
                                    Text(verbatim: "Loading...")
                                })
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                                .padding(.bottom, 100)
                                .overlay(Text(bread.name)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundColor(.white)
                                    })
                            }
                        }
                    }
                }
            }
        }
                .tabItem {
                    VStack {
                        Image(systemName: "2.circle")
                        Text("LazyGrid")
                    }
                }
                .tag(1)

            List(data.animals) { animal in
                DisclosureGroup(animal.name) {
                    VStack(alignment: .leading) {
                        ForEach(animal.breeds, id: \.name) { breed in
                            HStack {
                                AsyncImage(url: URL(string: breed.url), placeholder: {
                                    Text(verbatim: "Loading...")
                                    })
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    Text(breed.name)
                                    }
                                    .padding(.trailing)
                                    }
                                }
                            }
                        }
                .tabItem {
                    VStack {
                        Image(systemName: "3.circle")
                        Text("List")
                    }
                }
                .tag(2)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
