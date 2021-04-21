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
    
    @discardableResult
    func login(completion: @escaping () -> Void) -> URLSessionTask? {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
        
        return nil
    }
    
}
