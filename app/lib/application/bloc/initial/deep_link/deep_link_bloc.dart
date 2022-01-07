import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretend/domain/entities/timetable_with_subjects.dart';
import 'package:pretend/domain/usecases/import_timetable.dart';

part 'deep_link_event.dart';

part 'deep_link_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  final Future<String?> Function() _getInitialUri;
  final Stream<String?> _uriLinkStream;
  final ImportTimetable _importTimetable;

  DeepLinkBloc(
    this._getInitialUri,
    this._uriLinkStream, {
    required ImportTimetable importTimetable,
  })  : _importTimetable = importTimetable,
        super(DeepLinkInitial());

  StreamSubscription? _uniLinkSubscription;
  static String? _initialUriLink;

  @override
  Stream<DeepLinkState> mapEventToState(DeepLinkEvent event) async* {
    if (event is CheckForDeepLinksEvent) {
      yield* _initUniLinks();
    } else if (event is DisposeDeepLinksEvent) {
      _uniLinkSubscription?.cancel();
    } else if (event is _UriFoundEvent) {
      yield* _beginImportFromFile(event.uri);
    } else if (event is _UriNotFoundEvent) {
      yield DeepLinkNotFound();
    } else if (event is _ErrorEvent) {
      yield DeepLinkError(event.msg);
    }
  }

  void _subscribeToUniStream() {
    _uniLinkSubscription?.cancel();
    _uniLinkSubscription = _uriLinkStream.listen(
      (uri) => add(uri != null ? _UriFoundEvent(uri) : _UriNotFoundEvent()),
    )..onError(
        (err) => add(_ErrorEvent(err.toString())),
      );
  }

  Stream<DeepLinkState> _initUniLinks() async* {
    yield DeepLinkLoading();
    try {
      final uri = await _getInitialUri();
      if (uri != null) {
        if (uri == _initialUriLink) {
          _subscribeToUniStream();
        } else {
          _initialUriLink = uri;
          yield* _beginImportFromFile(uri);
        }
      } else {
        yield DeepLinkNotFound();
      }
    } catch (e) {
      yield DeepLinkError(e.toString());
    }
  }

  Stream<DeepLinkState> _beginImportFromFile(String contentUri) async* {
    yield ImportInProgress();
    final params = ImportTimetableParams(contentUri);
    final importEither = await _importTimetable(params);
    yield importEither.fold(
      (failure) => ImportFailed(failure.message),
      (tws) => ImportSuccessful(tws),
    );
  }
}
