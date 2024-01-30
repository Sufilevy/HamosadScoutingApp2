import '/models/cubit.dart';

class GameReportSummary {
  final won = Cubit(false);
  final defenseFocus = Cubit(DefenseFocus.defaultValue);
  final canIntakeFromFloor = Cubit(false);

  /// If the robot can only score in the SPEAKER from a single location, this is the description
  /// of that location. <br> If it can shoot from multiple locations, this is empty.
  final pinnedShooterLocation = Cubit<String>('');
  final notes = Cubit('');

  Json get data {
    return {
      'won': won.data,
      'defenseFocus': defenseFocus.data.toString(),
      'canIntakeFromFloor': canIntakeFromFloor.data,
      'pinnedShooterLocation':
          pinnedShooterLocation.data.isEmpty ? null : pinnedShooterLocation.data,
      'notes': notes.data,
    };
  }

  void clear() {
    won.data = false;
    canIntakeFromFloor.data = false;
    pinnedShooterLocation.data = '';
    defenseFocus.data = DefenseFocus.defaultValue;
    notes.data = '';
  }
}

enum DefenseFocus {
  none,
  half,
  almostOnly;

  static DefenseFocus get defaultValue => none;

  @override
  String toString() {
    switch (this) {
      case DefenseFocus.none:
        return 'none';
      case DefenseFocus.half:
        return 'half';
      case DefenseFocus.almostOnly:
        return 'almostOnly';
    }
  }
}
