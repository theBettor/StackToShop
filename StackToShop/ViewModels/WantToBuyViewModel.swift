//
//  WantToBuyViewModel.swift
//  StackToShop
//
//  Created by 김찬교 on 2023/12/28.
//

import UIKit


class WantToBuyViewModel {
    
    // 원래의 배열 데이터에도 접근 필요
    let dataManager: WantToBuyListType
    
    private var member: WantToBuy?
    private var index: Int? // 새로운 멤버를 생성했을때나 몇번째 멤버를 업데이트할지 알려면 index를 갖고 있어야한다.
    
    // (의존성 주입) 멤버, 인덱스를 가지고 뷰모델 생성
    init(dataManager: WantToBuyListType, with member: WantToBuy? = nil, index: Int? = nil) {
        self.dataManager = dataManager
        self.member = member
        self.index = index
    }
    
    // Output
    var wtbImage: UIImage? {
        member?.wtbImage
        
        // 멤버 가지지 않고 구현한다면
        //guard let index = self.index else { return UIImage() }
        //return dataManager[index].memberImage
    }
    
    var wtbIdString: String? {
        String(member?.wtbId ?? WantToBuy.wtbNumbers)
    }
    
    var nameString: String? {
        member?.name
    }
    
    var costString: String? {
        member != nil ? String(member!.cost!) : ""
    }
    
    var expectedmethodString: String? {
        member?.expetedmethod
    }
    
    var whenString: Date? {
        member?.when
    }
    
    var buttonTitle: String {
        member != nil ? "UPDATE" : "SAVE"
    }
    
    
    // Input
    func handleButtonTapped(image: UIImage?, name: String?, cost: String?, expectedmethod: String?, when: Date?) {
        if member != nil {
            updateWantToBuy(image: image, name: name, cost: cost, expectedmethod: expectedmethod, when: when)
        } else {
            makeNewWantToBuy(image: image, name: name, cost: cost, expectedmethod: expectedmethod, when: when)
        }
    }
    
    
    // Logic
    // 기존의 멤버를 업데이트
    private func updateWantToBuy(image: UIImage?, name: String?, cost: String?, expectedmethod: String?, when: Date?) {
        
        guard let member = self.member,
              let index = self.index else { return }
        
        let costInt = Int(cost ?? "") ?? 0
        
        // (뷰모델이 가지고 있는) 멤버 업데이트 ⭐️
        self.member = WantToBuy(exitingWantToBuy: member, image: image, name: name, cost: costInt, expectedmethod: expectedmethod, when: when)
        
        // 멤버 배열 업데이트 ⭐️
        self.dataManager.updateWtbInfo(index: index, with: self.member!)
    }
    
    // 새로운 멤버를 생성
    private func makeNewWantToBuy(image: UIImage?, name: String?, cost: String?, expectedmethod: String?, when: Date?) {
        
        let costInt = Int(cost ?? "") ?? 0
        
        // 새로운 멤버를 생성해서 ⭐️
        let newWtb = WantToBuy(image: image, name: name, cost: costInt, expectedmethod: expectedmethod, when: when)
        
        // 멤버 배열 업데이트 ⭐️
        self.dataManager.makeNewWtb(newWtb)
    }
    
    // 전화면으로 돌아가기
    func backToBeforeVC(fromCurrentVC: UIViewController, animated: Bool) {
        let navCon = fromCurrentVC.navigationController
        navCon?.popViewController(animated: animated)
    }
}
