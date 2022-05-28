//
//  AuthService.swift
//  sello
//
//

import RxCocoa
import RxSwift

class AuthService {
    
    func login(
        login: String,
        password: String
    ) -> Signal<AuthData> {
        
        let method = "v1/login"
        return JSONAPI.perform(method: method, requestType: .post)
        // TODO: убрать при появлении backend
            .mapTo(AuthData.init(token: "14Asad$52D^6e"))
//            .map { json in
//                try Parser().parse(AuthData.self, rawData: JSON(json))
//            }
            .take(1)
            .asSignal(onErrorJustReturn: .init(token: .empty))
    }
}
