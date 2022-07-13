//
//  SimpleViewModel.swift
//  InfinityNumbers
//
//
//

import Foundation
import RxSwift
import RxCocoa

protocol SimpleViewModelProtocol {
    var numbers: Driver<[Int]> { get }
    var fetchMoreDatas: PublishSubject<Void> { get }
}

final class SimpleViewModel: SimpleViewModelProtocol {
    
    var numbers: Driver<[Int]> {
        numberSubj.asDriver(onErrorJustReturn: [])
    }
    var numberSubj: BehaviorSubject<[Int]>
    var fetchMoreDatas = PublishSubject<Void>()
    
    var di: DIProtocol
    let model = SimpleModel()
    let provider = DataProvider()
    var bag = DisposeBag()
    
    init(di: DIProtocol) {
        self.di = di
        self.numberSubj = BehaviorSubject<[Int]>(value: [])
        bind()
    }
    
    private func bind() {
        numberSubj.onNext(model.numbers)
        
        fetchMoreDatas.subscribe { [weak self] _ in
            guard let self = self else { return }
            self.fetchNumbers()
        }.disposed(by: bag)
    }
    
    func fetchNumbers() {
        provider.requestDataPrime(size: 10) { [weak self] number in
            guard let self = self else { return }
            self.model.numbers = number
            self.numberSubj.onNext(self.model.numbers)
        }
    }
}
