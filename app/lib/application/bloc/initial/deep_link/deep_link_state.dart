part of 'deep_link_bloc.dart';

abstract class DeepLinkState extends Equatable {
  const DeepLinkState();

  @override
  List<Object> get props => const [];
}

class DeepLinkInitial extends DeepLinkState {
  const DeepLinkInitial();
}

class DeepLinkLoading extends DeepLinkState {
  const DeepLinkLoading();
}

class DeepLinkNotFound extends DeepLinkState {
  const DeepLinkNotFound();
}

class DeepLinkError extends DeepLinkState {
  final String msg;

  const DeepLinkError(this.msg);

  @override
  List<Object> get props => [msg];
}

class ImportInProgress extends DeepLinkState {
  const ImportInProgress();
}

class ImportSuccessful extends DeepLinkState {
  final TimetableWithSubjects tws;

  const ImportSuccessful(this.tws);

  @override
  List<Object> get props => [tws];
}

class ImportFailed extends DeepLinkState {
  final String msg;

  const ImportFailed(this.msg);

  @override
  List<Object> get props => [msg];
}
