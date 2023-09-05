
import XCTest
@testable import algorithm_swift

class LeakyBucketTests: XCTestCase {
  
  func testAllowRequestWithinCapacity() async {
    let bucket = LeakyBucket(capacity: 10.0, rate: 5.0)
    
    // 初始容量足够，所以请求应该被允许
    let result = await bucket.allowRequest(size: 5.0)
    XCTAssertTrue(result)
  }
  
  func testDenyRequestExceedingCapacity() async {
    let bucket = LeakyBucket(capacity: 10.0, rate: 5.0)
    
    // 超出容量，请求应被拒绝
    let result = await bucket.allowRequest(size: 11.0)
    XCTAssertFalse(result)
  }
  
  func testLeakageOverTime() async {
    let bucket = LeakyBucket(capacity: 10.0, rate: 1.0) // 每秒漏出1单位
    
    let initialResult = await bucket.allowRequest(size: 5.0) // 当前水量为5
    XCTAssertTrue(initialResult)
    
    try? await Task.sleep(nanoseconds: UInt64(2 * 1_000_000_000)) // Sleep 2 seconds
    
    // 经过2秒钟，漏出2单位，所以新请求（大小为7）应该被允许，因为剩余水量为3
    let finalResult = await bucket.allowRequest(size: 7.0)
    XCTAssertTrue(finalResult)
  }
}
