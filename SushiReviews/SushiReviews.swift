//
//  SushiReviews.swift
//  SushiReviews
//
//  Created by Mark Wong on 2022-03-25.
//

import Foundation

func sushiReviews() {
  // 1. Get user inputs and create an adj list
  let firstLine = readLine()!.split(separator: " ").map { Int($0)! }
  let n = firstLine[0]
  
  let secondLine = readLine()!.split(separator: " ").map { Int($0)! }
  let realSushi = Set<Int>(secondLine)
  
  let graph = Graph(V: n)
  for _ in 0..<n - 1 {
    let edge = readLine()!.split(separator: " ").map { Int($0)! }
    graph.addEdge(from: edge[0], to: edge[1])
  }
  
  var start = realSushi.first!
  var visited = [Bool](repeating: false, count: graph.V)
  
  // 2. Remove leaf nodes which are not real sushi restaurant -> prunning
  //  - recursively
  //  - degree of node = 1 -> leaf node
  func removeLeaves(from graph: Graph, v: Int, sushi: Set<Int>, visited: inout [Bool]) {
    visited[v] = true
    for u in graph.adj(to: v) {
      if !visited[u] {
        removeLeaves(from: graph, v: u, sushi: sushi, visited: &visited)
      }
    }
    
    // if it's a leaf node and it's not in the real sushi list
    if graph.degree(of: v) == 1 && !sushi.contains(v) {
      graph.removeAllEdges(from: v)
    }
  }
  
  removeLeaves(from: graph, v: start, sushi: realSushi, visited: &visited)
  
  // 3. Find diameter of the tree -> DFS * 2 or BFS * 2
  func getDiameter(_ dfs: DFS, _ diameter: inout Int, _ n: Int) -> Int {
    for i in 0..<n {
      if dfs.depth(of: i) > dfs.depth(of: diameter) {
        diameter = i
      }
    }
    
    return diameter
  }
  
  let dfs = DFS(G: graph, s: start)
  var maxVertex = getDiameter(dfs, &start, n)
  
  let dfs2 = DFS(G: graph, s: maxVertex)
  let diameter = getDiameter(dfs2, &maxVertex, n)
   
  // 4. answer = 2 * the number of edges - diameter
  print(graph.E * 2 - dfs2.depth(of: diameter))
}
