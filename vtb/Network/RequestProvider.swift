//
//  BaseDataProvider.swift
//  vtb
//
//  Created by Alina Golubeva on 21.04.2021.
//

import UIKit

private enum RequestPath: String {
    var baseURLPath: String {
        return ""
    }
    
    case login = ""
}

enum RequestProvider {

    static func login() -> URLRequest? {
        return nil
    }
}
