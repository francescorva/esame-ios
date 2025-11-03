import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss
    @State private var userData = UserData()
    @State private var confermaPassword = ""
    @State private var errore = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .resizable()
                        .frame(width: 96, height: 96)
                        .foregroundColor(.blue.opacity(0.9))
                        .padding(.top, 8)
                    
                    MyTextField(withIcon: "person.fill",
                                textValue: $userData.username,
                                isMandatory: true,
                                textHint: "Username")
                    
                    MyTextField(withIcon: "key.fill",
                                textValue: $userData.password,
                                isMandatory: true,
                                isSecret: true,
                                textHint: "Password")
                    
                    MyTextField(withIcon: "key.fill",
                                textValue: $confermaPassword,
                                isMandatory: true,
                                isSecret: true,
                                textHint: "Conferma Password")
                    
                    if !errore.isEmpty {
                        Text(errore)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                    
                    Button {
                        registraUtente()
                    } label: {
                        Text("Crea Account")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(userData.username.isEmpty || userData.password.isEmpty || confermaPassword.isEmpty)
                    
                    Spacer(minLength: 40)
                }
                .padding(.horizontal)
            }
            .navigationTitle("Registrazione")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Chiudi") { dismiss() }
                }
            }
        }
    }
    
    private func registraUtente() {
        guard userData.password == confermaPassword else {
            errore = "Le password non coincidono"
            return
        }
        if userManager.register(username: userData.username, password: userData.password) {
            errore = ""
            dismiss()
        } else {
            errore = "Utente già esistente"
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(UserManager())
}
