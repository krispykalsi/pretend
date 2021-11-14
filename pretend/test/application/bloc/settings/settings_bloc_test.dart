import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/application/bloc/settings/settings_bloc.dart';
import 'package:core/error.dart';
import 'package:core/usecase.dart';
import 'package:pretend/domain/usecases/get_app_settings.dart';
import 'package:pretend/domain/usecases/mark_app_visited_first_time.dart';
import 'package:pretend/domain/usecases/set_app_theme_color.dart';

import '../../../fixtures/app_settings.dart';
import 'settings_bloc_test.mocks.dart';

@GenerateMocks([GetAppSettings, MarkAppVisitedFirstTime, SetAppThemeColor])
void main() {
  late MockGetAppSettings mockGetAppSettings;
  late MockMarkAppVisitedFirstTime mockMarkAppVisitedFirstTime;
  late MockSetAppThemeColor mockSetAppThemeColor;
  late SettingsBloc bloc;

  setUp(() {
    mockGetAppSettings = MockGetAppSettings();
    mockMarkAppVisitedFirstTime = MockMarkAppVisitedFirstTime();
    mockSetAppThemeColor = MockSetAppThemeColor();
    bloc = SettingsBloc(
      getAppSettings: mockGetAppSettings,
      markAppVisitedFirstTime: mockMarkAppVisitedFirstTime,
      setAppThemeColor: mockSetAppThemeColor,
    );
  });

  group('GetAppSettings usecase', () {
    final tAppSettings = getTestAppSettings;
    final tParams = NoParams();

    test(
      'should get app settings from usecase',
      () async {
        when(mockGetAppSettings(tParams))
            .thenAnswer((_) async => Right(tAppSettings));
        bloc.add(const GetAppSettingsEvent());
        await untilCalled(mockGetAppSettings(tParams));
        verify(mockGetAppSettings(tParams));
      },
    );

    test(
      'should emit [Loading, Loaded] when settings are gotten successfully',
      () {
        when(mockGetAppSettings(any))
            .thenAnswer((_) async => Right(tAppSettings));
        final expectedOrder = [
          const AppSettingsLoading(),
          AppSettingsLoaded(tAppSettings),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedOrder));
        bloc.add(const GetAppSettingsEvent());
      },
    );

    group(
      'should emit [Loading, Error] when settings are NOT gotten successfully',
      () {
        test(
          'on CacheFailure',
          () async {
            final cacheFailure = CacheFailure();
            when(mockGetAppSettings(any))
                .thenAnswer((_) async => Left(cacheFailure));
            final expectedOrder = [
              const AppSettingsLoading(),
              AppSettingsError(cacheFailure.message),
            ];
            expectLater(bloc.stream, emitsInOrder(expectedOrder));
            bloc.add(const GetAppSettingsEvent());
            await untilCalled(mockGetAppSettings(tParams));
            verify(mockGetAppSettings(tParams));
          },
        );
      },
    );
  });

  group('MarkAppVisitedFirstTime usecase', () {
    const tFlag = true;
    const tParams = MarkAppVisitedFirstTimeParams(tFlag);
    test(
      'should set app visited first flag to true from usecase',
          () async {
        when(mockMarkAppVisitedFirstTime(tParams))
            .thenAnswer((_) async => const Right(null));
        bloc.add(const SetFirstTimeVisitedFlagEvent(tFlag));
        await untilCalled(mockMarkAppVisitedFirstTime(tParams));
        verify(mockMarkAppVisitedFirstTime(tParams));
      },
    );

    test(
      'should emit [ChangeInProgress, ChangedSuccessfully] when settings are changed successfully',
          () async {
        when(mockMarkAppVisitedFirstTime(tParams))
            .thenAnswer((_) async => const Right(null));
        final expectedOrder = [
          const SettingsChangeInProgress(),
          const SettingsChangedSuccessfully(),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedOrder));
        bloc.add(const SetFirstTimeVisitedFlagEvent(tFlag));
        await untilCalled(mockMarkAppVisitedFirstTime(tParams));
        verify(mockMarkAppVisitedFirstTime(tParams));
      },
    );

    group(
      'should emit [ChangeInProgress, ChangeError] when settings are NOT changed successfully',
          () {
        test(
          'on CacheFailure',
              () async {
            final cacheFailure = CacheFailure();
            when(mockMarkAppVisitedFirstTime(tParams))
                .thenAnswer((_) async => Left(cacheFailure));
            final expectedOrder = [
              const SettingsChangeInProgress(),
              SettingsChangeError(cacheFailure.message),
            ];
            expectLater(bloc.stream, emitsInOrder(expectedOrder));
            bloc.add(const SetFirstTimeVisitedFlagEvent(tFlag));
            await untilCalled(mockMarkAppVisitedFirstTime(tParams));
            verify(mockMarkAppVisitedFirstTime(tParams));
          },
        );
      },
    );
  });

  group('SetAppThemeColor usecase', () {
    const tColor = Color(0x00000123);
    const tParams = SetAppThemeColorParams(tColor);

    test(
      'should set app\'s theme color from usecase',
          () async {
        when(mockSetAppThemeColor(tParams))
            .thenAnswer((_) async => const Right(null));
        bloc.add(const SetThemeColorEvent(tColor));
        await untilCalled(mockSetAppThemeColor(tParams));
        verify(mockSetAppThemeColor(tParams));
      },
    );

    test(
      'should emit [ChangeInProgress, ChangedSuccessfully] when settings are changed successfully',
          () async {
        when(mockSetAppThemeColor(any))
            .thenAnswer((_) async => const Right(null));
        final expectedOrder = [
          const SettingsChangeInProgress(),
          const SettingsChangedSuccessfully(),
        ];
        expectLater(bloc.stream, emitsInOrder(expectedOrder));
        bloc.add(const SetThemeColorEvent(tColor));
        await untilCalled(mockSetAppThemeColor(tParams));
        verify(mockSetAppThemeColor(tParams));
      },
    );

    group(
      'should emit [ChangeInProgress, ChangeError] when settings are NOT changed successfully',
          () {
        test(
          'on CacheFailure',
              () async {
            final cacheFailure = CacheFailure();
            when(mockSetAppThemeColor(any))
                .thenAnswer((_) async => Left(cacheFailure));
            final expectedOrder = [
              const SettingsChangeInProgress(),
              SettingsChangeError(cacheFailure.message),
            ];
            expectLater(bloc.stream, emitsInOrder(expectedOrder));
            bloc.add(const SetThemeColorEvent(tColor));
            await untilCalled(mockSetAppThemeColor(tParams));
            verify(mockSetAppThemeColor(tParams));
          },
        );
      },
    );
  });
}
