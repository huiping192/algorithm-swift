
public protocol Prioritizable {
  var priority: QueuePriority { get }
}

public enum QueuePriority {
  case high
  case medium
  case low
}

public actor PriorityQueue<T: Prioritizable> {
  
  private var highPriorityQueue: [T] = []
  private var mediumPriorityQueue: [T] = []
  private var lowPriorityQueue: [T] = []
  
  public func enqueue(_ message: T) {
    switch message.priority {
    case .high:
      highPriorityQueue.append(message)
    case .medium:
      mediumPriorityQueue.append(message)
    case .low:
      lowPriorityQueue.append(message)
    }
  }
  
  public func dequeue() -> T? {
    if !highPriorityQueue.isEmpty {
      return highPriorityQueue.removeFirst()
    } else if !mediumPriorityQueue.isEmpty {
      return mediumPriorityQueue.removeFirst()
    } else if !lowPriorityQueue.isEmpty {
      return lowPriorityQueue.removeFirst()
    } else {
      return nil
    }
  }
  
  public var isEmpty: Bool {
    highPriorityQueue.isEmpty && mediumPriorityQueue.isEmpty && lowPriorityQueue.isEmpty
  }
}
