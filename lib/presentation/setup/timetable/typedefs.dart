import 'package:pretend/domain/entities/timeslots.dart';

import 'timeslot_grid_tile_state.dart';

typedef DaySelectionState = Map<Timeslots, TimeslotGridTileState>;
typedef WeekSelectionState = Map<String, DaySelectionState>;
typedef SubjectWiseTimetable = Map<String, WeekSelectionState>;