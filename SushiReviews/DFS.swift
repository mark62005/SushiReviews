//
//  DFS.swift
//  SushiReviews
//
//  Created by Mark Wong on 2022-04-04.
//

import Foundation

struct DFS {
  private(set) var visited: [Bool]
  private(set) var depth: [Int]
  private(set) var count: Int = 0
  private let s: Int
  
  public init(G: Graph, s: Int) {
    self.s = s
    self.visited = [Bool](repeating: false, count: G.V)
    self.depth = [Int](repeating: -1, count: G.V)
    dfs(G, v: s, d: 0)
  }
  
  private mutating func dfs(_ G: Graph, v: Int, d: Int) {
    visited[v] = true
    depth[v] = d
    count += 1
    for u in G.adj(to: v) {
      if !visited[u] {
        dfs(G, v: u, d: d + 1)
      }
    }
  }
  
  public func visited(v: Int) -> Bool {
    return visited[v]
  }
  
  public func depth(of v: Int) -> Int {
    return depth[v]
  }
}
