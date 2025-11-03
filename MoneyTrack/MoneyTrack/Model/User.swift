import Foundation

struct UserData {
    var username: String = ""
    var password: String = ""
    var nome: String = ""
    var cognome: String = ""
    var via: String = ""
    var citta: String = ""
    var eta: Int = 0

    var isAllMandatoryFieldsEmpty: Bool {
        return username.isEmpty || password.isEmpty
    }

    var isAnyMandatoryFieldsEmpty: Bool {
        return username.isEmpty && password.isEmpty && nome.isEmpty && cognome.isEmpty
    }

    mutating func emptyFields() {
        nome = ""
        cognome = ""
        username = ""
        password = ""
    }
}
