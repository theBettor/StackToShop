//
//  WantToBuy.swift
//  StackToShop
//
//  Created by 김찬교 on 2023/12/28.
//

import UIKit

// WantToBuy 모델
struct WantToBuy {
    lazy var wtbImage: UIImage? = {
        guard let name = name else {
            return UIImage(systemName: "photo.badge.plus")
        }
        return UIImage(named: "\(name).png") ?? UIImage(systemName: "photo.badge.plus")
    }()
    
    var currentDateTime: Date
    
    static var wtbNumbers: Int = 0
    
    let wtbId: Int
    
    var name: String?
    var cost: Int?
    var expetedmethod: String?
    var when: Date?
    
    // 새롭게 생성할때
    init(image: UIImage? = nil, name: String?, cost: Int?, expectedmethod: String?, when: Date?) {
        
        self.wtbId = WantToBuy.wtbNumbers
        
        self.name = name
        self.cost = cost
        self.expetedmethod = expectedmethod
        self.when = when
        
        WantToBuy.wtbNumbers += 1
    }
    
    // 기존 리스트 업데이트 할때
    init(exitingWantToBuy: WantToBuy, image: UIImage? = nil, name: String?, cost: Int?, expectedmethod: String?, when: Date?) {
        
        self = exitingWantToBuy
        
        self.wtbImage = image
        self.name = name
        self.cost = cost
        self.expetedmethod = expectedmethod
        self.when = when
    }
}
