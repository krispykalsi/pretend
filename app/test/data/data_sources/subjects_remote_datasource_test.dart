import 'package:core/error.dart';
import 'package:csv/csv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pretend/data/data_sources/subjects_remote_datasource.dart';

import '../../fixtures/fixture_reader.dart';
import '../../fixtures/subjects.dart';
import 'subjects_remote_datasource_test.mocks.dart';

@GenerateMocks([CsvToListConverter, Client])
void main() {
  late MockCsvToListConverter mockCsvParser;
  late MockClient mockClient;
  late SubjectsRemoteDataSource dataSource;

  setUp(() {
    mockCsvParser = MockCsvToListConverter();
    mockClient = MockClient();
    dataSource = SubjectsRemoteDataSource(
      csvParser: mockCsvParser,
      httpClient: mockClient,
    );
  });

  final tCollegeID = "1";
  final tUri =
      "https://raw.githubusercontent.com/ISKalsi/pretend/main/api/subjects/$tCollegeID.csv";
  final tUrl = Uri.parse(tUri);
  final tCsv = csvFixture("subjects.csv");
  final tCsvList = [
    <dynamic>["code", "name"],
    <dynamic>["HU-351a", "International Trade"],
    <dynamic>["IT-502", "Computer Networks"],
    <dynamic>["IT-504", "Theory of Computing"],
  ];
  final tSubjectModels = getTestSubjectModels;

  test('should successfully extract SubjectModels from csv via remote source',
      () async {
    when(mockClient.read(any)).thenAnswer((_) async => tCsv);
    when(mockCsvParser.convert(any)).thenAnswer((_) => tCsvList);

    final actualSubjects = await dataSource.getSubjects(tCollegeID);

    expect(actualSubjects, tSubjectModels);
    verify(mockClient.read(tUrl));
    verify(mockCsvParser.convert(tCsv));
  });

  test('should throw ServerException when the url is incorrect', () async {
    final tMsg = "url not found";
    when(mockClient.read(tUrl)).thenThrow(ClientException(tMsg));

    final actualSubjectsCall =
        () async => await dataSource.getSubjects(tCollegeID);

    expect(actualSubjectsCall, throwsA(const TypeMatcher<ServerException>()));
    verify(mockClient.read(tUrl));
    verifyZeroInteractions(mockCsvParser);
  });

  test('should throw NoRemoteDataFoundException when the csv is empty',
      () async {
    when(mockClient.read(tUrl)).thenAnswer((_) async => "");

    final actualSubjectsCall =
        () async => await dataSource.getSubjects(tCollegeID);

    expect(actualSubjectsCall, throwsA(TypeMatcher<NoRemoteDataException>()));
    verify(mockClient.read(tUrl));
    verifyZeroInteractions(mockCsvParser);
  });
}
