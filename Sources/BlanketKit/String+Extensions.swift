//
//  File.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-29 (09).
//

import Foundation

extension String {
  public func path(startingAt component: String, excludeStart: Bool = false) -> String {

    let url = URL(fileURLWithPath: self)

    guard var firstIndex = url.pathComponents.firstIndex(of: component) else { return "" }

    if excludeStart { firstIndex += 1 }

    return url.pathComponents[firstIndex...url.pathComponents.count - 1].joined(separator: "/")
  }
}
