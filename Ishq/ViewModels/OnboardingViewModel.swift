import Foundation
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var userType: Int = 0
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var promptOne = ""
    @Published var promptTwo = ""
    @Published var promptThree = ""
    
    @Published var isLoading: Bool = false
    @Published var navigationTag: String?

    
    
    
    private var cancellables = Set<AnyCancellable>()
    
    func selectUserType() {
        do{
            DispatchQueue.main.async {
                self.isLoading = true
            }
            
            print("Attempting to begin onboarding")
            DispatchQueue.main.async {
                self.isLoading = false
                self.navigationTag = "SETUP_SINGLES_PROFILE"
            }
        } catch{
            print("Something went wrong ")
        }
    }
    
    func saveUserType() async{
        guard let url = URL(string: "https://your-endpoint-url") else {
            print("Invalid endpoint URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData = ["selection": String(userType)]

        do {
            let jsonData = try await JSONSerialization.data(withJSONObject: requestData, options: [])
            request.httpBody = jsonData
        } catch {
            print("Error encoding request data: \(error)")
            return
        }

        URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: Response.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Request completed successfully")
                case .failure(let error):
                    print("Request failed with error: \(error.localizedDescription)")
                }
            }, receiveValue: { response in
                // Handle response if needed
            })
            .store(in: &cancellables)
    }

}

struct Response: Codable {
    // Define the structure of your response object
    // based on your endpoint's response
}
