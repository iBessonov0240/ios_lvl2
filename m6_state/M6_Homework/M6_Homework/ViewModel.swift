import Foundation

final class ViewModel: ObservableObject {
    let service: UnstableNetworkService
    @Published var animals: [Animal] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init(service: UnstableNetworkService) {
        self.service = service
    }

    func fetchAnimals() {
        isLoading = true
        errorMessage = nil
        service.getData { result in
            self.isLoading = false
            self.animals = result
        } failure: { error in
            self.errorMessage = error.localizedDescription
        }
    }
}
