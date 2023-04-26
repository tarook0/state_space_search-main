import '../heap/heap.dart';
import '../queue/queue.dart';
// 1
export '../heap/heap.dart' show Priority;

/*. When you use your priority queue in the future to implement Dijkstra’s 
algorithm, exporting Priority here will save you from having to import 
heap.dart separately.*/
// 2
class PriorityQueue<E extends Comparable<dynamic>> implements Queue<E> {
  PriorityQueue({
    List<E>? elements,
    Priority priority = Priority.max,
  }) {
    // 3
    _heap = Heap<E>(elements: elements, priority: priority);
  }
  late Heap<E> _heap;
  @override
  bool get isEmpty => _heap.isEmpty;
  @override
  E? get peek => _heap.peek;
// 1
  @override
  bool enqueue(E element) {
    _heap.insert(element);
    return true;
  }

// 2
  @override
  E? dequeue() => _heap.remove();
}
