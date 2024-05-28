//
//  NetworkLayer.swift
//  networklayer
//
//  Created by mert can çifter on 11.05.2024.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case apiFailure
    case invalidResponse
    case decodingError
}

fileprivate enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

typealias Parameters = [String : Any]

fileprivate enum URLEncoding {
    case queryString
    case none
    
    func encode(_ request: inout URLRequest, with parameters: Parameters)  {
        switch self {
         case .queryString:
            guard let url = request.url else { return }
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
               !parameters.isEmpty {
                
                urlComponents.queryItems = [URLQueryItem]()
                for (k, v) in parameters {
                    let queryItem = URLQueryItem(name: k, value: "\(v)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
                request.url = urlComponents.url
            }
            
        case .none:
            break
        }
    }
}


protocol APIRequestProtocol {
    static func makeGetRequest<T: Codable> (path: String, queries: Parameters, onCompletion: @escaping(T?, NetworkError?) -> ())
    static func makePostRequest<T: Codable> (path: String, body: Parameters, onCompletion: @escaping (T?, NetworkError?) -> ())
}

enum APIRequestManager: APIRequestProtocol {
    
    case getAPI(path: String, data: Parameters)
    case postAPI(path: String, data: Parameters)
    
    static var baseURL: URL = URL(string: "")!
    
    private var path: String {
        switch self {
        case .getAPI(let path, _):
            return path
        case .postAPI(let path, _):
            return path
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getAPI:
            return .get
        case .postAPI:
            return .post
        }
    }
    
    fileprivate func addHeaders(request: inout URLRequest) {
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = TokenManager.shared.getJWTToken() {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
    
    fileprivate func asURLRequest() -> URLRequest {

        var request = URLRequest(url: Self.baseURL.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        
        var parameters = Parameters()
        
        switch self {
        case .getAPI(_, let queries):
            queries.forEach({parameters[$0] = $1})
            URLEncoding.queryString.encode(&request, with: parameters)
            
        case .postAPI(_, let queries):
            queries.forEach({parameters[$0] = $1})
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters) {
                request.httpBody = jsonData
            }
        }
        self.addHeaders(request: &request)
        return request
    }
    
    fileprivate static func makeRequest<S: Codable>(session: URLSession, request: URLRequest, model: S.Type, onCompletion: @escaping(S?, NetworkError?) -> ()) {
        session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                onCompletion(nil, NetworkError.apiFailure)
                return
            }
            if httpResponse.statusCode == 401 {
               TokenManager.shared.refreshJWTToken { success in
                   if success {
                       var newRequest = request
                       if let token = TokenManager.shared.getJWTToken() {
                           newRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                       }
                       makeRequest(session: session, request: newRequest, model: model, onCompletion: onCompletion)
                   } else {
                       onCompletion(nil, NetworkError.apiFailure)
                   }
               }
               return
           }
            
            
            guard error == nil, let responseData = data else { onCompletion(nil, NetworkError.apiFailure) ; return }
            do {
                if let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? Parameters  {
                   
                    let jsonData = try JSONSerialization.data(withJSONObject: json)
                    let response = try JSONDecoder().decode(S.self, from: jsonData)
                    onCompletion(response, nil)
                    
                } else if let json = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                            as? [Parameters] {
                    let jsonData = try JSONSerialization.data(withJSONObject: json)
                    let response = try JSONDecoder().decode(S.self, from: jsonData)
                    onCompletion(response, nil)
                }
                else {
                    onCompletion(nil,  NetworkError.invalidResponse)
                    return
                }
            } catch {
                print(error)
                onCompletion(nil, NetworkError.decodingError)
                return
            }
        }.resume()
    }
    
    static func makeGetRequest<T: Codable> (path: String, queries: Parameters, onCompletion: @escaping(T?, NetworkError?) -> ()) {
        let session = URLSession.shared
        let request: URLRequest = Self.getAPI(path: path, data: queries).asURLRequest()
        
        makeRequest(session: session, request: request, model: T.self) { (result, error) in
            onCompletion(result, error)
        }
    }
    
    static func makePostRequest<T: Codable> (path: String, body: Parameters, onCompletion: @escaping (T?, NetworkError?) -> ()) {
        let session = URLSession.shared
        let request: URLRequest = Self.postAPI(path: path, data: body).asURLRequest()
        
        makeRequest(session: session, request: request, model: T.self) { (result, error) in
            onCompletion(result, error)
        }
    }
}
