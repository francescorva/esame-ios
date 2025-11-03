import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var userManager: UserManager
    @State private var mostraForm = false
    @State private var mostraProfilo = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(spacing: 24) {
                    VStack(spacing: 6) {
                        Text("Saldo attuale")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("€\(dataManager.getSaldoTotale(), specifier: "%.2f")")
                            .font(.system(size: 42, weight: .bold))
                            .foregroundColor(dataManager.getSaldoTotale() >= 0 ? .green : .red)
                    }
                    .padding(.top, 28)
                    
                    HStack(spacing: 28) {
                        VStack {
                            Text("Entrate")
                                .font(.headline)
                                .foregroundColor(.green)
                            Text("€\(dataManager.getEntrateTotali(), specifier: "%.2f")")
                                .font(.title3)
                        }
                        VStack {
                            Text("Uscite")
                                .font(.headline)
                                .foregroundColor(.red)
                            Text("€\(dataManager.getUsciteTotali(), specifier: "%.2f")")
                                .font(.title3)
                        }
                    }
                    
                    Button {
                        mostraForm.toggle()
                    } label: {
                        Label("Aggiungi Movimento", systemImage: "plus.circle.fill")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                            .shadow(color: .blue.opacity(0.15), radius: 4, x: 0, y: 2)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ultimi movimenti")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding(.leading)
                        
                        if dataManager.transazioni.isEmpty {
                            Text("Nessun movimento registrato.")
                                .foregroundColor(.gray)
                                .padding(.leading)
                        } else {
                            ForEach(Array(dataManager.transazioni.sorted(by: { $0.data > $1.data }).prefix(5)), id: \.id) { mov in
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(mov.titolo)
                                            .font(.subheadline)
                                            .fontWeight(.medium)
                                        Text(mov.categoria)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                    Text("€\(mov.importo, specifier: "%.2f")")
                                        .foregroundColor(mov.tipo == .entrata ? .green : .red)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top, 6)
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { mostraProfilo.toggle() } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $mostraForm) {
                AggiungiMovimentoView()
                    .environmentObject(dataManager)
            }
            .sheet(isPresented: $mostraProfilo) {
                ProfiloView()
                    .environmentObject(userManager)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(DataManager())
        .environmentObject(UserManager())
}
