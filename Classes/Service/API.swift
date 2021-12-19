//
//  API.swift
//  sello
//
//  Created by user on 16.12.2021.
//

import Foundation
import RxSwift
import RxCocoa

enum RequestType: String {

    case get = "GET"
    case post = "POST"
}

class APIURLSession: URLSession, URLSessionDelegate {
    static let apiShared = APIURLSession()
    
    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void
    ) -> URLSessionDataTask {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(
            configuration: configuration,
            delegate: self,
            delegateQueue: nil
        )
        
        return session.dataTask(with: request, completionHandler: completionHandler)
    }
}


class API<DataType: RawData> {

    class func defaultTimeout() -> TimeInterval { 30 }
    typealias Query = [(String, String?)]
    typealias Response = (rawData: DataType, headers: [String: String])

    /// Выполняет запрос к API.
    /// - parameter method: метод API
    /// - parameter requestType: тип запроса (GET/POST)
    /// - parameter body: тело запроса
    /// - parameter timeoutInterval: интервал времени ожидания
    /// - parameter headers: заголовки запроса
    static func perform(
        method: String,
        requestType: RequestType,
        query: Query = [],
        body: Data? = nil,
        timeoutInterval: TimeInterval = defaultTimeout(),
        headers: [String: String] = [:]
    ) -> Observable<Response> {

        let request = createRequest(
            method,
            type: requestType,
            query: query,
            body: body,
            timeoutInterval: timeoutInterval,
            headers: headers
        )

        return performRequest(request)
    }
    
    static func performRequest(_ request: URLRequest) -> Observable<Response> {

        let observable = APIURLSession.apiShared.rx.response(request: request)
            .flatMapLatest { response, data -> Observable<Response> in
                let parsed = parse(data: data, response: response)
                return parsed
            }
        return observable
    }
    
    class func parse(data: Data, response: HTTPURLResponse) -> Observable<Response> {
        return Observable.empty()
    }
    
    private static func createRequest(
        _ method: String,
        type: RequestType,
        query: Query,
        body: Data?,
        timeoutInterval: TimeInterval,
        headers: [String: String]
    ) -> URLRequest {

        var components = URLComponents()
        var queryItems = [URLQueryItem]()
        for (name, value) in query {
            queryItems.append(URLQueryItem(name: name, value: value))
        }
        components.queryItems = queryItems

        var request: URLRequest = URLRequest(url: components.url!)
        request.timeoutInterval = timeoutInterval
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpMethod = type.rawValue
        request.httpBody = body

        for (key, header) in headers {
            request.setValue(header, forHTTPHeaderField: key)
        }
        return request
    }
}
