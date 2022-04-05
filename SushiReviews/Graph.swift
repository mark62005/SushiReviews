//
//  Graph.swift
//  SushiReviews
//
//  Created by Mark Wong on 2022-04-04.
//

import Foundation

class Graph {
  let V: Int
  private(set) var E: Int
  private var adj: [Set<Int>]
  
  public init(V: Int) {
    self.V = V
    self.E = 0
    self.adj = [Set<Int>](repeating: Set<Int>(), count: V)
  }
  
  public func addEdge(from u: Int, to v: Int) {
    E += 1
    adj[u].insert(v)
    adj[v].insert(u)
  }
  
  public func degree(of v: Int) -> Int {
    return adj[v].count
  }
  
  public func adj(to v: Int) -> Set<Int> {
    return adj[v]
  }
  
  public func removeAllEdges(from v: Int) {
    E -= adj[v].count
    for u in adj[v] {
      adj[u].remove(v)
    }
    adj[v].removeAll()
  }
}
