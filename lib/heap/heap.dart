enum Priority { max, min }

class Heap<E extends Comparable<dynamic>> {
  Heap({List<E>? elements, this.priority = Priority.max}) {
    this.elements = (elements == null) ? [] : elements;
    _buildHeap();
  }

  void _buildHeap() {
    if (isEmpty) return;
    final start = elements.length ~/ 2 - 1;
    for (var i = start; i >= 0; i--) {
      _siftDown(i);
    }
  }

  late final List<E> elements;
  final Priority priority;
  bool get isEmpty => elements.isEmpty;
  int get size => elements.length;
  E? get peek => (isEmpty) ? null : elements.first;
//Calling peek will give you the maximum value in the collection for a max-heap, or
//the minimum value in the collection for a min-heap. This is an O(1) operation.
  int _leftChildIndex(int parentIndex) {
    return 2 * parentIndex + 1;
  }

  int _rightChildIndex(int parentIndex) {
    return 2 * parentIndex + 2;
  }

  int _parentIndex(int childIndex) {
    return (childIndex - 1) ~/ 2;
  }

  bool _firstHasHigherPriority(E valueA, E valueB) {
    if (priority == Priority.max) {
      return valueA.compareTo(valueB) > 0;
    }
    return valueA.compareTo(valueB) < 0;
  }

  int _higherPriority(int indexA, int indexB) {
    if (indexA >= elements.length) return indexB;
    final valueA = elements[indexA];
    final valueB = elements[indexB];
    final isFirst = _firstHasHigherPriority(valueA, valueB);
    return (isFirst) ? indexA : indexB;
  }

  void _swapValues(int indexA, int indexB) {
    final temp = elements[indexA];
    elements[indexA] = elements[indexB];
    elements[indexB] = temp;
  }

  void insert(E value) {
    // 1
    elements.add(value);
    // 2
    _siftUp(elements.length - 1);
  }

  void _siftUp(int index) {
    var child = index;
    var parent = _parentIndex(child);
    // 3
    while (child > 0 && child == _higherPriority(child, parent)) {
      _swapValues(child, parent);
      child = parent;
      parent = _parentIndex(child);
    }
  }

  @override
  String toString() => elements.toString();

  void _siftDown(int index) {
    // 1
    var parent = index;
    while (true) {
      // 2
      final left = _leftChildIndex(parent);
      final right = _rightChildIndex(parent);
      // 3
      var chosen = _higherPriority(left, parent);
      // 4
      chosen = _higherPriority(right, chosen);
      // 5
      if (chosen == parent) return;
      // 6
      _swapValues(parent, chosen);
      parent = chosen;
    }
  }

  E? remove() {
    if (isEmpty) return null;
    // 1
    _swapValues(0, elements.length - 1);
    // 2
    final value = elements.removeLast();
    // 3
    _siftDown(0);
    return value;
  }

  E? removeAt(int index) {
    final lastIndex = elements.length - 1;
    // 1
    if (index < 0 || index > lastIndex) {
      return null;
    }
    // 2
    if (index == lastIndex) {
      return elements.removeLast();
    }
    // 3
    _swapValues(index, lastIndex);
    final value = elements.removeLast();
    // 4
    _siftDown(index);
    _siftUp(index);
    return value;
  }

  int indexOf(E value, {int index = 0}) {
    // 1
    if (index >= elements.length) {
      return -1;
    }
    // 2
    if (_firstHasHigherPriority(value, elements[index])) {
      return -1;
    }
    // 3
    if (value == elements[index]) {
      return index;
    }
    // 4
    final left = indexOf(value, index: _leftChildIndex(index));
    if (left != -1) return left;
    return indexOf(value, index: _rightChildIndex(index));
  }
}
