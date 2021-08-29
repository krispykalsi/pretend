import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/core/network/network_info.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker mockConnectionChecker;
  late NetworkInfoImplementation networkInfo;

  setUp(() {
    mockConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImplementation(mockConnectionChecker);
  });

  test(
    'should forward call to InternetConnectionChecker.hasConnection',
    () {
      final tHasConnectionFuture = Future.value(true);
      when(mockConnectionChecker.hasConnection)
          .thenAnswer((realInvocation) => tHasConnectionFuture);

      final result = networkInfo.isConnected;

      verify(mockConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    },
  );
}
