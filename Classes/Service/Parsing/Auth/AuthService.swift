//
//  AuthService.swift
//  sello
//
//

import RxCocoa
import RxSwift

class AuthService {
    
    func login(
        login: Driver<String?>,
        password: Driver<String?>
    ) -> Signal<AuthData> {
        
        let method = "v1/login"
        return JSONAPI.perform(method: method, requestType: .post)
            .map { json in
                
                try Parser().parse(AuthData.self, rawData: JSON(json))
            }
            .take(1)
            .asSignal(onErrorJustReturn: .init(token: .empty))
    }
}
