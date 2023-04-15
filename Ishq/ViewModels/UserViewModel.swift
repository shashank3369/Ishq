//
//  UserViewModel.swift
//  Ishq
//
//  Created by Shashank Kothapalli on 4/8/23.
//

import Foundation
import Combine

final class UserViewModel: ObservableObject {
    
    @Published var user: User?
    
    private var bag = Set<AnyCancellable>()
    
    func fetchUserDetails() {
        var components = URLComponents(string: "https://us-west-2.aws.data.mongodb-api.com/app/ishq-uywcj/endpoint/getUserProfileDetails")
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "userType", value: "singles"))
        queryItems.append(URLQueryItem(name: "userId", value: "637acb6ba79a2aca3bfa182f"))
        components?.queryItems = queryItems
        if let url = components?.url {
            print(url.absoluteURL)
            print(url.path)
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .decode(type: User.self, decoder: JSONDecoder())
                .sink { res in
                    switch res {
                    case .failure(let error):
                        print(error.localizedDescription)
                    default:
                        break
                    }
                    
                } receiveValue: { [weak self] user in
                    print("birthday: \(user.birthday)")
                    print("firstName: \(user.firstName)")
                    self?.user = user
                }
                .store(in: &bag)

        }
    }
}
