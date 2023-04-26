class Vertex<T> {
  const Vertex({
    required this.index,
    required this.data,
    this.busWaite,
    this.taxiWaite,
  });
  final double? taxiWaite;
  final double? busWaite;
  final int index;
  final T data;
  @override
  String toString() => data.toString();
}

class Edge<T> {
  const Edge(
    this.source,
    this.destination, [
    this.weight,
    this.TI,
    this.B,
    this.W,
  ]);
  final bool? TI;
  final bool? B;
  final bool? W;
  final Vertex<T> source;
  final Vertex<T> destination;
  final double? weight;
}

enum EdgeType { directed, undirected }

enum EdgeTrans { tb, w, tbw }

abstract class Graph<E> {
  Iterable<Vertex<E>> get vertices;
  Vertex<E> createVertex(E data, {double taxiWait = 0, double busWaite = 0});
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType,
    EdgeTrans edgeTrans,
    double? weight,
  });
  List<Edge<E>> edges(Vertex<E> source);
  double? weight(
    Vertex<E> source,
    Vertex<E> destination,
  );
}

class AdjacencyList<E> implements Graph<E> {
  final busSpeed = 10;
  final taxiSpeed = 30;
  final humanSpeed = 5.5;

  final Map<Vertex<E>, List<Edge<E>>> _connections = {};
  var _nextIndex = 0;
  @override
  Iterable<Vertex<E>> get vertices => _connections.keys;
  @override
  Vertex<E> createVertex(E data, {double taxiWait = 0, double busWaite = 0}) {
    // 1
    final vertex = Vertex(
      index: _nextIndex,
      data: data,
      taxiWaite: taxiWait,
      busWaite: busWaite,
    );
    _nextIndex++;
    // 2
    _connections[vertex] = [];
    return vertex;
  }

  @override
  void addEdge(
    Vertex<E> source,
    Vertex<E> destination, {
    EdgeType edgeType = EdgeType.undirected,
    EdgeTrans edgeTrans = EdgeTrans.tbw,
    double? weight,
    bool TI = false,
    bool? B = false,
    bool? W = false,
  }) {
    // 1
    _connections[source]?.add(
      //cheack if it
      Edge(source, destination, weight, TI, B, W),
    );
    // 2
    if (edgeType == EdgeType.undirected) {
      _connections[destination]?.add(
        Edge(destination, source, weight, TI, B, W),
      );
    }
  }

//This gets the stored outgoing edges for the provided vertex. If source is unknown,
// the method returns an empty list.
  @override
  List<Edge<E>> edges(Vertex<E> source) {
    return _connections[source] ?? [];
  }

  @override
  double? weight(
    Vertex<E> source,
    Vertex<E> destination,
  ) {
    final match = edges(source).where((edge) {
      return edge.destination == destination;
    });
    if (match.isEmpty) return null;
    return match.first.weight;
  }

  @override
  String toString() {
    final result = StringBuffer();
    // 1
    _connections.forEach((vertex, edges) {
      // 2
      final destinations = edges.map((edge) {
        return edge.destination;
      }).join(', ');
      // 3
      result.writeln('$vertex --> $destinations');
    });
    return result.toString();
  }
}
