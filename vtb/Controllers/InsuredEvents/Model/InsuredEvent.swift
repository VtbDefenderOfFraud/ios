//
//  InsuredEvent.swift
//  vtb
//
//  Created by Alina Golubeva on 16.05.2021.
//

import UIKit

struct InsuredEvent {
    let name: String
    let sum: String
    let currentStage: Stage
    let stages: [Stage]
    let icon: String
    
    struct Stage: Equatable {
        let status: Status
        let name: String
        let date: String
    }
    
    enum Status {
        case previous
        case current
        case future
        
        var color: UIColor {
            switch self {
            case .previous: return UIColor(red: 96/255, green: 174/255, blue: 139/255, alpha: 1)
            case .current: return UIColor(red: 245/255, green: 191/255, blue: 78/255, alpha: 1)
            case .future: return UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
            }
        }
    }
}

struct UserInfo: Codable {
    let id: Int
    let passport, name: String
    let creditIndex, ratingMin, ratingMax: Int
    let creditApprovalChance: Double
}
