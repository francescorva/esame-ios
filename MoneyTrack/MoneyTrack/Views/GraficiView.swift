import SwiftUI
import Charts

struct GraficiView: View {
    @EnvironmentObject var dataManager: DataManager
    
    struct GraficoDato: Identifiable {
        let id = UUID()
        let categoria: String
        let valore: Double
    }
    
    private var datiUscitePerCategoria: [GraficoDato] {
        var categorie: [String: Double] = [:]
        for t in dataManager.transazioni where t.tipo == .uscita {
            categorie[t.categoria, default: 0] += t.importo
        }
        return categorie.map { GraficoDato(categoria: $0.key, valore: $0.value) }
    }
    
    private var totaleUscite: Double {
        dataManager.getUsciteTotali()
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    Text("Distribuzione Uscite per Categoria")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    if datiUscitePerCategoria.isEmpty {
                        Text("Non ci sono uscite registrate.")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    } else {
                        Chart(datiUscitePerCategoria) { item in
                            SectorMark(
                                angle: .value("Importo", item.valore),
                                innerRadius: .ratio(0.55),
                                angularInset: 1.5
                            )
                            .foregroundStyle(by: .value("Categoria", item.categoria))
                        }
                        .chartLegend(.visible)
                        .frame(height: 280)
                        .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Totale Uscite")
                            .font(.headline)
                        Text("€\(totaleUscite, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .navigationTitle("Grafici")
        }
    }
}

#Preview {
    GraficiView()
        .environmentObject(DataManager())
}
