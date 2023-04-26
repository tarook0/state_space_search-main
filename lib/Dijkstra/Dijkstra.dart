// ignore_for_file: file_names

import '../graph/graph.dart';
import '../priority_queue/priority_queue.dart';

class Pair<T> extends Comparable<Pair<T>> {
  Pair(this.distance, [this.vertex]);
  double distance;
  Vertex<T>? vertex;
  @override
  int compareTo(Pair<T> other) {
    if (distance == other.distance) return 0;
    if (distance > other.distance) return 1;
    return -1;
  }

  @override
  String toString() => '($distance, $vertex)';
}

class Dijkstra<E> {
  Dijkstra(this.graph);
  final Graph<E> graph;

  Map<Vertex<E>, Pair<E>?> shortestPaths(Vertex<E> source) {
    // 1
    final queue = PriorityQueue<Pair<E>>(priority: Priority.min);
    final visited = <Vertex<E>>{};
    final paths = <Vertex<E>, Pair<E>?>{};
    // 2
    for (final vertex in graph.vertices) {
      paths[vertex] = null;
    }
    // 3
    queue.enqueue(Pair(0, source));
    paths[source] = Pair(0);
    visited.add(source);
    // 1
    while (!queue.isEmpty) {
      final current = queue.dequeue()!;
      // 2
      final savedDistance = paths[current.vertex]!.distance;
      if (current.distance > savedDistance) continue;
      // 3
      visited.add(current.vertex!);
      for (final edge in graph.edges(current.vertex!)) {
        final neighbor = edge.destination;
        // 1   If you’ve previously visited the destination vertex, then ignore it and go on.
        if (visited.contains(neighbor)) continue;
        // 2
        final weight = edge.weight ?? double.infinity;
        final totalDistance = current.distance + weight;
        // 3 Compare the known distance to that vertex with the new total that you just
        //calculated. Newly discovered vertices will get a default distance of infinity.
        final knownDistance = paths[neighbor]?.distance ?? double.infinity;
        // 4 If you’ve found a shorter route this time around, then update paths and enqueue
        //this vertex for visiting later. No worries if the same vertex is already enqueued.
        //You’ll discard the obsolete one when it shows up.
        if (totalDistance < knownDistance) {
          paths[neighbor] = Pair(totalDistance, current.vertex);
          queue.enqueue(Pair(totalDistance, neighbor));
        }
      }
    }
    return paths;
  }

  List<Vertex<E>> shortestPath(
    Vertex<E> source,
    Vertex<E> destination, {
    Map<Vertex<E>, Pair<E>?>? paths,
  }) {
    // 1
    final allPaths = paths ?? shortestPaths(source);
    // 2
    if (!allPaths.containsKey(destination)) return [];
    var current = destination;
    final path = <Vertex<E>>[current];
    // 3
    while (current != source) {
      final previous = allPaths[current]?.vertex;
      if (previous == null) return [];
      path.add(previous);
      current = previous;
    }
    // 4
    return path.reversed.toList();
  }
}
