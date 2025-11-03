import SwiftUI

struct MovimentiView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var mostraForm = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dataManager.transazioni.sorted(by: { $0.data > $1.data })) { transazione in
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(transazione.titolo)
                                .font(.headline)
                            Text(transazione.categoria)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(transazione.data.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("€\(transazione.importo, specifier: "%.2f")")
                            .font(.headline)
                            .foregroundColor(transazione.tipo == .entrata ? .green : .red)
                    }
                    .padding(.vertical, 4)
                }
                .onDelete(perform: dataManager.deleteTransaction)
            }
            .navigationTitle("Movimenti")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) { EditButton() }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        mostraForm.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $mostraForm) {
                AggiungiMovimentoView()
                    .environmentObject(dataManager)
            }
        }
    }
}

#Preview {
    MovimentiView()
        .environmentObject(DataManager())
}
