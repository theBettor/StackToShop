//
//  WantToBuyListViewModel.swift
//  StackToShop
//
//  Created by 김찬교 on 2023/12/28.
//

import UIKit


class WantToBuyListViewModel {
    
    let dataManager: WantToBuyListType
    
    let title: String
    
    // 멤버리스트 배열 데이터 ⭐️⭐️⭐️
    private var wtbList: [WantToBuy] {
        return dataManager.getWtbList()
    }
    
    // 의존성 주입
    init(dataManager: WantToBuyListType, title: String) {
        self.dataManager = dataManager
        self.title = title
    }
    
    
    // Output
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.wtbList.count
    }
    
    // 뷰모델 생성
    func wanttobuyViewModelAtIndex(_ index: Int) -> WantToBuyViewModel {
        let member = self.wtbList[index]
        return WantToBuyViewModel(dataManager: self.dataManager, with: member, index: index)
    }
    
    
    // Input
    func makeNewWtb(_ member: WantToBuy) {
        dataManager.makeNewWtb(member)
    }
    
    func updateWtbInfo(index: Int, with member: WantToBuy) {
        dataManager.updateWtbInfo(index: index, with: member)
    }
    
    
    // Logic
    func handleNextVC(_ index: Int? = nil, fromCurrentVC: UIViewController, animated: Bool) {
        // 기존의 멤버가 있을때
        if let index = index {
            let wanttobuyVM = wanttobuyViewModelAtIndex(index)
            goToNextVC(with: wanttobuyVM, fromCurrentVC: fromCurrentVC, animated: animated)
        // 새로운 멤버 생성시
        } else {
            let newVM = WantToBuyViewModel(dataManager: self.dataManager, with: nil, index: nil)
            goToNextVC(with: newVM, fromCurrentVC: fromCurrentVC, animated: animated)
        }
    }
    
    private func goToNextVC(with wanttobuyVM: WantToBuyViewModel, fromCurrentVC: UIViewController, animated: Bool) {
                
        let navVC = fromCurrentVC.navigationController
        
        let detailVC = DetailViewController(viewModel: wanttobuyVM)
        navVC?.pushViewController(detailVC, animated: animated)
    }
    
}
