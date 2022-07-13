//
//  FebonachiViewModel.swift
//  InfinityNumbers
//
//
//

import Foundation
import RxSwift
import RxCocoa

protocol FebonachiViewModelProtocol {
    var numbers: Driver<[Int]> { get }
    var fetchMoreDatas: PublishSubject<Void> { get }
}

final class FebonachiViewModel: FebonachiViewModelProtocol {
    
    var numbers: Driver<[Int]> {
        numberSubj.asDriver(onErrorJustReturn: [])
    }
    
    var dataProvider = DataProvider()
    
    var di: DIProtocol
    
    let model = FebonachiModel()
    
    var numberSubj: BehaviorSubject<[Int]>
    
    var fetchMoreDatas = PublishSubject<Void>()
    
    let bag = DisposeBag()
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
        dataProvider.requestDataFebo(size: 10) { [weak self] number in
            guard let self = self else { return }
            self.model.numbers.append(contentsOf: number)
            self.numberSubj.onNext(self.model.numbers)
        }
    }
}
