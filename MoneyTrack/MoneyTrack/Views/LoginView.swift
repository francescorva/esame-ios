import SwiftUI

struct LoginView: View {
    @State private var userData = UserData()
    @State private var mostraRegistrazione = false
    @State private var errore = ""
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(spacing: 24) {
                    Image(systemName: "lock.circle.fill")
                        .resizable()
                        .frame(width: 96, height: 96)
                        .foregroundColor(.blue.opacity(0.9))
                        .padding(.top, 20)
                    
                    MyTextField(withIcon: "person.fill",
                                textValue: $userData.username,
                                isMandatory: true,
                                textHint: "Username")
                    
                    MyTextField(withIcon: "key.fill",
                                textValue: $userData.password,
                                isMandatory: true,
                                isSecret: true,
                                textHint: "Password")
                    
                    if !errore.isEmpty {
                        Text(errore)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
                    
                    Button {
                        if userManager.login(username: userData.username, password: userData.password) {
                            errore = ""
                        } else {
                            errore = "Credenziali errate"
                        }
                    } label: {
                        Text("Accedi")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .disabled(userData.username.isEmpty || userData.password.isEmpty)
                    
                    Button {
                        mostraRegistrazione = true
                    } label: {
                        Text("Registrati")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Login")
            .sheet(isPresented: $mostraRegistrazione) {
                RegisterView()
                    .environmentObject(userManager)
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserManager())
}
