import 'package:state_space_search/Dijkstra/Dijkstra.dart';
import 'package:state_space_search/graph/graph.dart';

void main() {
  final graph = AdjacencyList<String>();
  final a = graph.createVertex('A', busWaite: 5, taxiWait: 6);
  final b = graph.createVertex('B');
  final c = graph.createVertex('C');
  final d = graph.createVertex('D');
  final e = graph.createVertex('E');
  final f = graph.createVertex('F');
  final g = graph.createVertex('G');
  final h = graph.createVertex('H');
  graph.addEdge(a, b, weight: 8, edgeType: EdgeType.directed, TI: true, B: true, W: true);
  graph.addEdge(a, b, weight: 12, edgeType: EdgeType.directed);
  graph.addEdge(a, f, weight: 9, edgeType: EdgeType.directed, TI: true, B: true, W: true);
  graph.addEdge(a, g, weight: 1, edgeType: EdgeType.directed, edgeTrans: EdgeTrans.tbw);
  graph.addEdge(g, c, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(c, b, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(c, e, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(e, b, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(e, d, weight: 2, edgeType: EdgeType.directed);
  graph.addEdge(b, e, weight: 1, edgeType: EdgeType.directed);
  graph.addEdge(b, f, weight: 3, edgeType: EdgeType.directed);
  graph.addEdge(f, a, weight: 2, edgeType: EdgeType.directed, TI: false, B: true, W: true);
  graph.addEdge(h, g, weight: 5, edgeType: EdgeType.directed);
  graph.addEdge(h, f, weight: 2, edgeType: EdgeType.directed);
  final dijkstra = Dijkstra(graph);
  final allPaths = dijkstra.shortestPaths(a);
  print(allPaths);
  final path = dijkstra.shortestPath(a, d);
  print(path);

  // print(a.busWaite);
  // print(b.taxiWaite);

  // graph.edges(a).forEach((element) {
  //   print("source=${element.source}");
  //   print("TI=${element.TI}");
  //   print("B=${element.B}");
  //   print("W=${element.W}");
  //   print("destination=${element.destination}");
  // });
}
