import Foundation
import Combine

class DataManager: ObservableObject {
    @Published var transazioni: [Transaction] = []
    private let fileName = "transazioni.json"
    
    init() {
        loadTransactions()
    }
    
    private func getFileURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent(fileName)
    }
    
    func loadTransactions() {
        let url = getFileURL()
        guard let data = try? Data(contentsOf: url) else {
            transazioni = []
            return
        }
        if let decoded = try? JSONDecoder().decode([Transaction].self, from: data) {
            transazioni = decoded
        } else {
            transazioni = []
        }
    }
    
    func saveTransactions() {
        let url = getFileURL()
        if let encoded = try? JSONEncoder().encode(transazioni) {
            try? encoded.write(to: url)
        }
    }
    
    func addTransaction(_ transaction: Transaction) {
        transazioni.append(transaction)
        saveTransactions()
        salvaCategoria(transaction.categoria)
    }
    
    func deleteTransaction(at offsets: IndexSet) {
        for index in offsets.sorted(by: >) {
            transazioni.remove(at: index)
        }
        saveTransactions()
    }
    
    func getSaldoTotale() -> Double {
        let entrate = transazioni.filter { $0.tipo == .entrata }.reduce(0) { $0 + $1.importo }
        let uscite = transazioni.filter { $0.tipo == .uscita }.reduce(0) { $0 + $1.importo }
        return entrate - uscite
    }
    
    func getEntrateTotali() -> Double {
        transazioni.filter { $0.tipo == .entrata }.reduce(0) { $0 + $1.importo }
    }
    
    func getUsciteTotali() -> Double {
        transazioni.filter { $0.tipo == .uscita }.reduce(0) { $0 + $1.importo }
    }
    
    // MARK: - Categorie suggerite
    func getCategorieSalvate() -> [String] {
        UserDefaults.standard.stringArray(forKey: "categorieSalvate") ?? []
    }

    func salvaCategoria(_ categoria: String) {
        var categorie = getCategorieSalvate()
        if !categorie.contains(where: { $0.caseInsensitiveCompare(categoria) == .orderedSame }) {
            categorie.append(categoria)
            UserDefaults.standard.set(categorie, forKey: "categorieSalvate")
        }
    }
}
