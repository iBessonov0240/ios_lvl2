import UIKit
import Combine

// Задание 1
let randomNumbers = (1...5).map { _ in Int.random(in: 1...100) }
let publisher = Publishers.Sequence<[Int], Never>(sequence: randomNumbers)
let subscription = publisher
    .sink { value in
        print(value)
    }
