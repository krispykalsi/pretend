part of 'deep_link_bloc.dart';

abstract class DeepLinkState extends Equatable {
  const DeepLinkState();
}

class DeepLinkInitial extends DeepLinkState {
  const DeepLinkInitial();

  @override
  List<Object> get props => const [];
}

class DeepLinkLoading extends DeepLinkState {
  const DeepLinkLoading();

  @override
  List<Object> get props => const [];
}

class DeepLinkFound extends DeepLinkState {
  final String uri;

  const DeepLinkFound(this.uri);

  @override
  List<Object> get props => [uri];
}

class DeepLinkNotFound extends DeepLinkState {
  const DeepLinkNotFound();

  @override
  List<Object> get props => const [];
}

class DeepLinkError extends DeepLinkState {
  final String msg;

  const DeepLinkError(this.msg);

  @override
  List<Object> get props => [msg];
}
