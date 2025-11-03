import SwiftUI

struct AggiungiMovimentoView: View {
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    
    @State private var titolo = ""
    @State private var importo = ""
    @State private var categoria = ""
    @State private var tipo: TipoMovimento = .entrata
    @State private var data = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Dettagli movimento") {
                    TextField("Titolo", text: $titolo)
                    
                    TextField("Importo", text: $importo)
                        .keyboardType(.decimalPad)
                        .onChange(of: importo) { oldValue, newValue in
                            let allowed = "0123456789.,"
                            importo = newValue.filter { allowed.contains($0) }
                        }
                    
                    HStack {
                        TextField("Categoria", text: $categoria)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        Menu {
                            let categorie = dataManager.getCategorieSalvate()
                            if categorie.isEmpty {
                                Text("Nessuna categoria salvata")
                            } else {
                                ForEach(categorie, id: \.self) { cat in
                                    Button(cat) { categoria = cat }
                                }
                            }
                        } label: {
                            Image(systemName: "chevron.down.circle")
                                .foregroundColor(.blue)
                        }
                    }
                    
                    Picker("Tipo", selection: $tipo) {
                        Text("Entrata").tag(TipoMovimento.entrata)
                        Text("Uscita").tag(TipoMovimento.uscita)
                    }
                    
                    DatePicker("Data", selection: $data, displayedComponents: .date)
                }
                
                Section {
                    Button {
                        salvaMovimento()
                    } label: {
                        Text("Salva")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(!formCompleto)
                }
            }
            .navigationTitle("Nuovo movimento")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Chiudi") { dismiss() }
                }
            }
        }
    }
    
    private var formCompleto: Bool {
        !titolo.isEmpty && !importo.isEmpty && !categoria.isEmpty
    }
    
    private func salvaMovimento() {
        let valorePulito = importo.replacingOccurrences(of: ",", with: ".")
        guard let valore = Double(valorePulito) else { return }
        let nuovo = Transaction(titolo: titolo, importo: valore, categoria: categoria, data: data, tipo: tipo)
        dataManager.addTransaction(nuovo)
        dataManager.salvaCategoria(categoria)
        dismiss()
    }
}

#Preview {
    AggiungiMovimentoView()
        .environmentObject(DataManager())
}
