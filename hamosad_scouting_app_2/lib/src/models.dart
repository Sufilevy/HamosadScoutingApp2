typedef Json = Map<String, dynamic>;

enum DefenceFocus {
  almostAll,
  half,
  none;

  @override
  String toString() {
    switch (this) {
      case DefenceFocus.almostAll:
        return 'almostAll';
      case DefenceFocus.half:
        return 'half';
      case DefenceFocus.none:
        return 'none';
    }
  }
}
