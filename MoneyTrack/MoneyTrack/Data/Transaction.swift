import Foundation

enum TipoMovimento: String, Codable {
    case entrata
    case uscita
}

struct Transaction: Identifiable, Codable {
    let id: UUID
    var titolo: String
    var importo: Double
    var categoria: String
    var data: Date
    var tipo: TipoMovimento
    
    init(id: UUID = UUID(), titolo: String, importo: Double, categoria: String, data: Date = Date(), tipo: TipoMovimento) {
        self.id = id
        self.titolo = titolo
        self.importo = importo
        self.categoria = categoria
        self.data = data
        self.tipo = tipo
    }
}
