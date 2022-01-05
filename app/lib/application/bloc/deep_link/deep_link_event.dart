part of 'deep_link_bloc.dart';

abstract class DeepLinkEvent extends Equatable {
  const DeepLinkEvent();
}

class CheckForDeepLinksEvent extends DeepLinkEvent {
  const CheckForDeepLinksEvent();

  @override
  List<Object?> get props => const [];
}

class DisposeDeepLinksEvent extends DeepLinkEvent {
  const DisposeDeepLinksEvent();

  @override
  List<Object?> get props => const [];
}

class _UriFoundEvent extends DeepLinkEvent {
  final String uri;

  const _UriFoundEvent(this.uri);

  @override
  List<Object?> get props => [uri];
}

class _UriNotFoundEvent extends DeepLinkEvent {
  const _UriNotFoundEvent();

  @override
  List<Object?> get props => const [];
}

class _ErrorEvent extends DeepLinkEvent {
  final String msg;

  const _ErrorEvent(this.msg);

  @override
  List<Object?> get props => [msg];
}