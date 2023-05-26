//: [Previous](@previous)

import Foundation
import Combine

let url = URL(string: "https://go.skillbox.r")!

enum MyError: Error {
    case sessionError(Error)
}

let subscription = URLSession.shared.dataTaskPublisher(for: url)
    .mapError { MyError.sessionError($0) }
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("finished")
        case .failure(error: let error):
            print("finished with error: \(error)")
        }
    }, receiveValue: { value in
        print(value)
    })

//: [Next](@next)
