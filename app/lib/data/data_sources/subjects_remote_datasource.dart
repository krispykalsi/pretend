import 'package:core/error.dart';
import 'package:csv/csv.dart';
import 'package:csv/csv_settings_autodetection.dart';
import 'package:http/http.dart';
import 'package:pretend/data/models/subject_model.dart';

abstract class SubjectsRemoteDataSourceContract {
  Future<List<SubjectModel>> getSubjects(String collegeID);
}

class SubjectsRemoteDataSource implements SubjectsRemoteDataSourceContract {
  final CsvToListConverter csvParser;
  final Client httpClient;

  static const _baseUri =
      "https://raw.githubusercontent.com/ISKalsi/pretend/main/api/subjects";

  const SubjectsRemoteDataSource({
    required this.csvParser,
    required this.httpClient,
  });

  Future<String> _fetchCsvFile(String uri) async {
    final url = Uri.parse(uri);
    final csv = await httpClient.read(url);
    if (csv.isEmpty) throw NoRemoteDataException();
    return csv;
  }

  List<List> _parseCsvToList(String csv) {
    final settings = FirstOccurrenceSettingsDetector(
      eols: ['\n', '\r\n'],
      fieldDelimiters: ['|'],
    );
    return csvParser.convert(csv, csvSettingsDetector: settings);
  }

  List<SubjectModel> _parseListToSubjectModel(List<List> data) {
    const code = 0;
    const name = 1;

    final dataWithoutHeading = data.getRange(1, data.length).toList();
    dataWithoutHeading.removeWhere((subject) => subject.length < 2);
    final subjects = dataWithoutHeading
        .map<SubjectModel>(
          (subject) => SubjectModel(name: subject[name], code: subject[code]),
        )
        .toList(growable: false);
    return subjects;
  }

  @override
  Future<List<SubjectModel>> getSubjects(String collegeID) async {
    try {
      final uri = "$_baseUri/$collegeID.csv";
      final csv = await _fetchCsvFile(uri);
      final data = _parseCsvToList(csv);
      final subjects = _parseListToSubjectModel(data);
      return subjects;
    } on ClientException {
      throw ServerException();
    } on NoRemoteDataException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }
}

void main() async {
  final source = SubjectsRemoteDataSource(
    csvParser: CsvToListConverter(),
    httpClient: Client(),
  );
  final subs = await source.getSubjects("1");
  print(subs.length);
}
