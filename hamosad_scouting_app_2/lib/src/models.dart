import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';

typedef Json = Map<String, dynamic>;

class PieceInteraction {
  PieceInteraction({
    this.cone = false,
    this.cube = false,
    this.duration = ActionDuration.twoToFive,
  });

  bool cone, cube;
  ActionDuration duration;
}

class GridDropoffs {
  GridDropoffs()
      : dropoffs = List.generate(
          3,
          (_) => List.generate(3, (_) => PieceInteraction(), growable: false),
          growable: false,
        );

  List<List<PieceInteraction>> dropoffs;
}

class Dropoffs {
  Dropoffs() : grids = List.generate(3, (_) => GridDropoffs(), growable: false);

  List<GridDropoffs> grids;

  List<Json> toJson() {
    List<Json> json = [];

    grids.forEachIndexed((grid, gridIndex) {
      final gridName = Grid.values[gridIndex].toString();
      grid.dropoffs.forEachIndexed((row, rowIndex) {
        row.forEachIndexed((node, columnIndex) {
          if (node.cone || node.cube) {
            json.add({
              'grid': gridName,
              'row': rowIndex,
              'column': columnIndex,
              'gamePiece': node.cone ? 'cone' : 'cube',
              'duration': node.duration.toString(),
            });
          }
        });
      });
    });

    return json;
  }
}

class Pickups {
  Pickups()
      : floor = [],
        single = [],
        doubleFloor = [],
        doubleShelf = [];

  List<PieceInteraction> floor, single, doubleFloor, doubleShelf;

  List<Json> toJson() {
    List<Json> json = [];

    addToJson(position, pickups) {
      for (final pickup in pickups) {
        json.add({
          'position': position,
          'duration': pickup.duration.toString(),
          'gamePiece': pickup.cone ? 'cone' : 'cube',
        });
      }
    }

    addToJson('floor', floor);
    addToJson('single', single);
    addToJson('doubleFloor', doubleFloor);
    addToJson('doubleShelf', doubleShelf);

    return json;
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
  single,
  doubleFloor,
  doubleShelf;

  @override
  String toString() {
    switch (this) {
      case PickupPosition.floor:
        return 'floor';
      case PickupPosition.single:
        return 'single';
      case PickupPosition.doubleFloor:
        return 'doubleFloor';
      case PickupPosition.doubleShelf:
        return 'doubleShelf';
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
