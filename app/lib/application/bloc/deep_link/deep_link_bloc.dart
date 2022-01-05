import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'deep_link_event.dart';

part 'deep_link_state.dart';

class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  final Future<String?> Function() _getInitialUri;
  final Stream<String?> _uriLinkStream;

  DeepLinkBloc(this._getInitialUri, this._uriLinkStream)
      : super(DeepLinkInitial());

  StreamSubscription? _uniLinkSubscription;
  static String? _initialUriLink;

  @override
  Stream<DeepLinkState> mapEventToState(DeepLinkEvent event) async* {
    if (event is CheckForDeepLinksEvent) {
      final state = await initUniLinks();
      if (state != null) {
        yield state;
      } else {
        _uniLinkSubscription?.cancel();
        _uniLinkSubscription = _uriLinkStream.listen(
          (uri) => add(uri != null ? _UriFoundEvent(uri) : _UriNotFoundEvent()),
        )..onError(
            (err) => add(_ErrorEvent(err.toString())),
          );
      }
    } else if (event is DisposeDeepLinksEvent) {
      _uniLinkSubscription?.cancel();
    } else if (event is _UriFoundEvent) {
      yield DeepLinkFound(event.uri);
    } else if (event is _UriNotFoundEvent) {
      yield DeepLinkNotFound();
    } else if (event is _ErrorEvent) {
      yield DeepLinkError(event.msg);
    }
  }

  Future<DeepLinkState?> initUniLinks() async {
    try {
      final uri = await _getInitialUri();
      if (uri != null) {
        if (uri == _initialUriLink) {
          return null;
        } else {
          _initialUriLink = uri;
          return DeepLinkFound(_initialUriLink!);
        }
      } else {
        return DeepLinkNotFound();
      }
    } catch (e) {
      return DeepLinkError(e.toString());
    }
  }
}
