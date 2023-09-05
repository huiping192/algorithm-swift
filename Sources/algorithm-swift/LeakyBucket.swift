//
//  File.swift
//  
//
//  Created by 郭 輝平 on 2023/09/05.
//

import Foundation

public actor LeakyBucket {
  private var capacity: Double // 桶的容量
  private var rate: Double // 漏出的速率
  private var water: Double // 当前桶内的水量（或事件数量）
  private var lastLeakTime: TimeInterval // 上次漏水的时间
  
  public init(capacity: Double, rate: Double) {
    self.capacity = capacity
    self.rate = rate
    self.water = 0.0
    self.lastLeakTime = Date().timeIntervalSince1970
  }
  
  public func allowRequest(size: Double) -> Bool {
    let currentTime = Date().timeIntervalSince1970
    let timePassed = currentTime - lastLeakTime
    let leakAmount = timePassed * rate
    water = max(0, water - leakAmount) // 漏出水或事件
    lastLeakTime = currentTime
    
    if water + size <= capacity { // 如果新请求可以放入桶中
      water += size
      return true
    }
    
    return false
  }
}
