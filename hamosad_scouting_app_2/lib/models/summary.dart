enum DefenseFocus {
  almostAll,
  half,
  none;

  @override
  String toString() {
    switch (this) {
      case DefenseFocus.almostAll:
        return 'almostAll';
      case DefenseFocus.half:
        return 'half';
      case DefenseFocus.none:
        return 'none';
    }
  }
}
