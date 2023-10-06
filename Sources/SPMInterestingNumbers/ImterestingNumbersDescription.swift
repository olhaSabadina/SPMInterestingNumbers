//
//  requestNumberModel.swift
//  InterestingNumbers
//
//  Created by Olga Sabadina on 25.09.2023.
//

import Combine

public final class ImterestingNumbersDescription {
    
    private let networkManager = NetworkManager()
    
    public init() {}
    
    public func fetchNumber(typeRequest: TypeRequest, _ inputedNumbers: String) -> AnyPublisher<NumberModel, Error> {
        let isMath = typeRequest == .random
        return networkManager.fetchNumber(inputedNumbers, type: NumberModel.self, mathRequest: isMath)
    }
    
    public func fetchRangeNumber(_ inputedNumbers: String) -> AnyPublisher<RangeNumber, Error> {
        return networkManager.fetchNumber(inputedNumbers, type: RangeNumber.self)
    }
}
