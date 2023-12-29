//
//  WantToBuyListManager.swift
//  StackToShop
//
//  Created by 김찬교 on 2023/12/29.
//

import Foundation

protocol WantToBuyListType {
    func makeWtbListDatas()
    func getWtbList() -> [WantToBuy]
    func makeNewWtb(_ member: WantToBuy)
    func updateWtbInfo(index: Int, with member: WantToBuy)
    subscript(index: Int) -> WantToBuy { get set }
}


final class WantToBuyListManager: WantToBuyListType {
    
    // 멤버리스트를 저장하기 위한 배열
    private var wtbList: [WantToBuy] = []
    
    init() {
        makeWtbListDatas()
    }
    
    func makeWtbListDatas() {
        wtbList = [
            WantToBuy(name: "맥북에어15인치", cost: 2000000, expectedmethod: "쿠팡", when: .none),
        ]
    }
    
    func getWtbList() -> [WantToBuy] {
        return wtbList
    }
    
    func makeNewWtb(_ member: WantToBuy) {
        wtbList.append(member)
    }
    
    func updateWtbInfo(index: Int, with member: WantToBuy) {
        wtbList[index] = member
    }
    
    subscript(index: Int) -> WantToBuy {
        get {
            return wtbList[index]
        }
        set {
            wtbList[index] = newValue
        }
    }
}
