import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';

typedef Json = Map<String, dynamic>;

class Dropoff {
  Dropoff({
    required this.piece,
    required this.duration,
    required this.row,
  });

  Piece piece;
  ActionDuration? duration;
  int row;

  Json toJson() {
    return {
      'row': row,
      'piece': piece.toString(),
      if (duration != null) 'duration': duration.toString(),
    };
  }
}

class Dropoffs {
  Dropoffs() : dropoffs = [];

  List<Dropoff> dropoffs;

  List<Json> toJson() {
    return dropoffs.map((dropoff) => dropoff.toJson()).toList();
  }

  int countDropoffs(int row) {
    return dropoffs.count((dropoff) => dropoff.row == row);
  }
}

class Pickup {
  Pickup({required this.duration, required this.position, required this.piece});

  ActionDuration duration;
  PickupPosition position;
  Piece piece;

  Json toJson() {
    return {
      'duration': duration.toString(),
      'position': position.toString(),
      'piece': piece.toString(),
    };
  }
}

class Pickups {
  Pickups() : pickups = [];

  List<Pickup> pickups;

  List<Json> toJson() {
    return pickups.map((pickup) => pickup.toJson()).toList();
  }

  int countPickups(PickupPosition position) {
    return pickups.count((pickup) => pickup.position == position);
  }
}

class AutoClimb {
  ClimbState? state;
  ActionDuration? duration;

  Json toJson() {
    return {
      'state': state.toString(),
      'duration': duration.toString(),
    };
  }

  bool get isFilled {
    return state != null && (state! == ClimbState.none || duration != null);
  }
}

class EndgameClimb {
  ClimbState? state;
  RobotIndex? index;
  ActionDuration? duration;

  Json toJson() {
    return {
      'state': state.toString(),
      'robotIndex': index.toString(),
      'duration': duration.toString(),
    };
  }

  bool get isFilled {
    return state != null &&
        (state! == ClimbState.none || (index != null && duration != null));
  }
}

enum Grid {
  arenaWall,
  coop,
  loadingZone;

  @override
  String toString() {
    switch (this) {
      case Grid.arenaWall:
        return 'arenaWall';
      case Grid.coop:
        return 'coop';
      case Grid.loadingZone:
        return 'loadingZone';
    }
  }
}

enum Piece {
  cone(ScoutingTheme.cones),
  cube(ScoutingTheme.cubes);

  const Piece(this.color);

  final Color color;

  @override
  String toString() {
    switch (this) {
      case Piece.cone:
        return 'cone';
      case Piece.cube:
        return 'cube';
    }
  }
}

enum StartPosition {
  arenaWall,
  middle,
  loadingZone;

  @override
  String toString() {
    switch (this) {
      case StartPosition.arenaWall:
        return 'arenaWall';
      case StartPosition.middle:
        return 'middle';
      case StartPosition.loadingZone:
        return 'loadingZone';
    }
  }
}

enum PickupPosition {
  floor,
  loadingZone;

  @override
  String toString() {
    switch (this) {
      case PickupPosition.floor:
        return 'floor';
      case PickupPosition.loadingZone:
        return 'loadingZone';
    }
  }
}

enum ActionDuration {
  zeroToTwo,
  twoToFive,
  fivePlus;

  @override
  String toString() {
    switch (this) {
      case ActionDuration.zeroToTwo:
        return '0-2';
      case ActionDuration.twoToFive:
        return '2-5';
      case ActionDuration.fivePlus:
        return '5+';
    }
  }
}

enum ClimbState {
  none,
  docked,
  engaged,
  dockedByOther;

  @override
  String toString() {
    switch (this) {
      case ClimbState.none:
        return 'none';
      case ClimbState.docked:
        return 'docked';
      case ClimbState.engaged:
        return 'engaged';
      case ClimbState.dockedByOther:
        return 'dockedByOther';
    }
  }
}

enum RobotIndex {
  first,
  second,
  third;

  @override
  String toString() {
    switch (this) {
      case RobotIndex.first:
        return 'first';
      case RobotIndex.second:
        return 'second';
      case RobotIndex.third:
        return 'third';
    }
  }
}

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
