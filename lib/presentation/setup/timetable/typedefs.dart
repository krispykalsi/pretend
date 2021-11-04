import 'timeslot_grid_tile_state.dart';

typedef DaySelectionState = Map<String, TimeslotGridTileState>;
typedef WeekSelectionState = Map<String, DaySelectionState>;
typedef SubjectWiseTimetable = Map<String, WeekSelectionState>;