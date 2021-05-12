//
//  DataProvider.swift
//  vtb
//
//  Created by Alina Golubeva on 21.04.2021.
//

import Foundation
import Alamofire

final class DataProvider: NSObject {

    static let shared = DataProvider()
    
    private lazy var sessionManager: Session = {
        let evaluator = DisabledTrustEvaluator()
        let manager = ServerTrustManager(evaluators: ["51.144.2.50": evaluator])
        let session = Session(serverTrustManager: manager)
        
        return session
    }()
    
    @discardableResult
    func login(login: String, password: String, completion: @escaping (Response) -> Void) -> URLSessionTask? {
        guard let url = URL(string: "https://51.144.2.50:5000/connect/token") else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
//        urlRequest.en
        
        let body: [String: Any] = [
            "grant_type": "client_credentials",
            "client_id": login,
            "client_secret": password,
            "scope": "api1.all"
        ]
        
        let jsonString = body.reduce("") { "\($0)\($1.0)=\($1.1)&" }.dropLast()
        let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        
        urlRequest.httpBody = jsonData
        
        return self.request(urlRequest, completion: completion)
    }
    
    @discardableResult
    func history(completion: @escaping () -> Void) -> URLSessionTask? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
        
        return nil
    }
    
    @discardableResult
    func userInfo(completion: @escaping () -> Void) -> URLSessionTask? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
        
        return nil
    }
    
    @discardableResult
    func logout(completion: @escaping () -> Void) -> URLSessionTask? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            AppData.isRegistered = false
            UIApplication.mainDelegate.showRoot()
        }
        
        return nil
    }
    
}

extension DataProvider {
    @discardableResult
    private func request(_ request: URLRequest?,
                         completion: ((Response) -> Void)?) -> URLSessionTask? {
        guard let request = request else { return nil }
        
        let serverRequest = self.sessionManager.request(request)
        
        serverRequest.responseData(queue: .main) { resp in
            guard case .success(let data) = resp.result,
                  let urlResponse = resp.response else {
                                
                guard case .failure(let error) = resp.result,
                      error._code != NSURLErrorCancelled else {
                    completion?(Response(errorCode: .cancelled))
                    
                    return
                }
                
                completion?(Response(false))
                return
            }
            
            let json = try? JSONSerialization.jsonObject(with: data)
            
            var success = false
            switch urlResponse.statusCode {
            case 200..<300:
                success = true
            default:
                break
            }
            
            let response = Response(success, json: json)
            
            completion?(response)
        }

        return serverRequest.task
    }
}

extension DataProvider {
    
    struct Response {
        
        // MARK: – response properties
        
        private(set) var success = false
        private(set) var json: Any?
        private(set) var errorCode: ErrorCode?
        
        // MARK: – Error enum
        
        enum ErrorCode {
            
            case noInternet
            case cancelled
            case custom(error: String)
            
            var message: String {
                switch self {
                case .noInternet:
                    return "Нет подключения к интернету"
                case .cancelled:
                    return "Отменено"
                case .custom(let error):
                    return error
                }
            }
        }
        
        // MARK: – Initializations
        
        init(_ success: Bool, json: Any? = nil) {
            self.success = success
            self.json = json
            let dict = json as? [String: Any]
            
            if let error = dict?["error"] as? String {
                self.errorCode = .custom(error: error)
            }
        }
        
        init(errorCode: ErrorCode) {
            self.success = false
            self.errorCode = errorCode
            
            switch errorCode {
            case .noInternet:
                self.errorCode = .noInternet
            default:
                break
            }
        }
    }
}
