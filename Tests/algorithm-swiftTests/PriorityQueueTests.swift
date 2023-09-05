import XCTest
@testable import algorithm_swift

struct TestMessage: Prioritizable {
  var content: String
  var priority: QueuePriority
}

class PriorityQueueTests: XCTestCase {
  func testEnqueueAndDequeue() async {
    let highPriorityMessage = TestMessage(content: "High", priority: .high)
    let mediumPriorityMessage = TestMessage(content: "Medium", priority: .medium)
    let lowPriorityMessage = TestMessage(content: "Low", priority: .low)
    
    let queue = PriorityQueue<TestMessage>()
    
    await queue.enqueue(highPriorityMessage)
    await queue.enqueue(mediumPriorityMessage)
    await queue.enqueue(lowPriorityMessage)
    
    let dequeuedHigh = await queue.dequeue()
    XCTAssertEqual(dequeuedHigh?.content, "High")
    
    let dequeuedMedium = await queue.dequeue()
    XCTAssertEqual(dequeuedMedium?.content, "Medium")
    
    let dequeuedLow = await queue.dequeue()
    XCTAssertEqual(dequeuedLow?.content, "Low")
  }
  
  func testIsEmpty() async {
    let queue = PriorityQueue<TestMessage>()
    
    let initialIsEmpty = await queue.isEmpty
    XCTAssertTrue(initialIsEmpty)
    
    let message = TestMessage(content: "Test", priority: .medium)
    await queue.enqueue(message)
    
    let afterEnqueueIsEmpty = await queue.isEmpty
    XCTAssertFalse(afterEnqueueIsEmpty)
    
    _ = await queue.dequeue()
    
    let afterDequeueIsEmpty = await queue.isEmpty
    XCTAssertTrue(afterDequeueIsEmpty)
  }
  
}
