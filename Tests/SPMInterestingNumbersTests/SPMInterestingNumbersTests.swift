import XCTest
import Combine

@testable import SPMInterestingNumbers

final class SPMInterestingNumbersTests: XCTestCase {
    
    var interestingNumber: ImterestingNumbersDescription?
    var cancellable = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        interestingNumber = ImterestingNumbersDescription()
    }
    
    override func tearDown() {
        interestingNumber = nil
        cancellable.removeAll()
        super.tearDown()
    }
    
    func testFetchInterestihgNumber() {
        
        let expectation = XCTestExpectation(description: "Fetch InterestingNumber")
        interestingNumber?.fetchNumber(typeRequest: .year, "4/23")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected successful fetch, but got error: \(error)")
                }
            }, receiveValue: { value in
                let answerFromServer = value.text ?? ""
                let firstWord = answerFromServer.prefix(5)
                XCTAssertNotNil(value.text)
                XCTAssert(!answerFromServer.isEmpty)
                XCTAssertEqual(firstWord, "April")
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 15.0)
    }
    
    func testFetchRangeNumbersViewModel() {
        
        let expectation = XCTestExpectation(description: "Fetch RangeNumberViewModel")
        interestingNumber?.fetchRangeNumber("10..15")
        
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Expected successful fetch, but got error: \(error)")
                }
            }, receiveValue: { value in
                XCTAssert( value.count > 2 )
                XCTAssertFalse(value.isEmpty)
                XCTAssertEqual(value.keys.count, 6)
                
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5.0)
    }
}
