import Foundation
import Combine

class UserManager: ObservableObject {
    @Published var utenti: [RegisteredUser] = []
    @Published var utenteLoggato: RegisteredUser? = nil
    
    private let fileName = "utenti.json"
    
    init() {
        loadUsers()
    }
    
    private func getFileURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }
    
    func loadUsers() {
        let url = getFileURL()
        guard let data = try? Data(contentsOf: url) else {
            utenti = []
            return
        }
        if let decoded = try? JSONDecoder().decode([RegisteredUser].self, from: data) {
            utenti = decoded
        } else {
            utenti = []
        }
    }
    
    func saveUsers() {
        let url = getFileURL()
        if let encoded = try? JSONEncoder().encode(utenti) {
            try? encoded.write(to: url)
        }
    }
    
    func register(username: String, password: String) -> Bool {
        guard !utenti.contains(where: { $0.username == username }) else {
            return false
        }
        let nuovo = RegisteredUser(username: username, password: password)
        utenti.append(nuovo)
        saveUsers()
        utenteLoggato = nuovo
        return true
    }
    
    func login(username: String, password: String) -> Bool {
        if let user = utenti.first(where: { $0.username == username && $0.password == password }) {
            utenteLoggato = user
            return true
        }
        return false
    }
    
    func logout() {
        utenteLoggato = nil
    }
}
