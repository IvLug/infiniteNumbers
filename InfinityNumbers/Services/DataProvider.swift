//
//  DataProvider.swift
//  InfinityNumbers
//
//  
//

import Foundation

class DataProvider {
    
    private var offset: Int = 0
    
    private var numLoaded = 0
    private var sequence : [Int] = [0,1]
    
    func requestDataPrime(size: Int, completion: @escaping([Int]) -> Void) {
        if offset == 0 {
            offset = size * 2
        }
        let firstPrime = 2
        guard offset >= firstPrime else {
            fatalError("End of range has to be greater than or equal to \(firstPrime)!")
        }
        var numbers = Array(firstPrime...offset)
        var currentPrimeIndex = 0
        
        DispatchQueue.global(qos: .userInitiated).async {
            while currentPrimeIndex < numbers.count {
                let currentPrime = numbers[currentPrimeIndex]
                var numbersAfterPrime = numbers.suffix(from: currentPrimeIndex + 1)
                numbersAfterPrime.removeAll(where: { $0 % currentPrime == 0 })
                numbers = numbers.prefix(currentPrimeIndex + 1) + Array(numbersAfterPrime)
                
                currentPrimeIndex += 1
            }
            self.offset += size * 2
            
            DispatchQueue.main.async {
                completion(numbers)
            }
        }
    }
    
    func requestDataFebo(offset: Int = 1, size: Int, completion: @escaping([Int]) -> Void) {
        
        guard size > 1 else { return }
        var arr: [Int] = []
        if sequence.count == 2 {
            arr = sequence
        }
        let numPrev = numLoaded
        numLoaded = numPrev + size
        
        DispatchQueue.global(qos: .userInitiated).async {
            for _ in numPrev...self.numLoaded - 2 {
                let a = self.sequence[self.sequence.count-2]
                let b = self.sequence.last!
                
                if !a.addingReportingOverflow(b).overflow {
                    let sum = a + b
                    
                    self.sequence.append(sum)
                    arr.append(sum)
                }
            }
            
            DispatchQueue.main.async {
                completion(arr)
            }
        }
    }
}
