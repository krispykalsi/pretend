import 'package:core/error.dart';
import 'package:csv/csv.dart';
import 'package:http/http.dart';
import 'package:pretend/data/models/college_model.dart';
import 'package:pretend/data/models/subject_model.dart';

abstract class SubjectsRemoteDataSourceContract {
  Future<List<SubjectModel>> getSubjects(String collegeID);

  Future<List<CollegeModel>> getColleges();
}

class SubjectsRemoteDataSource implements SubjectsRemoteDataSourceContract {
  final CsvToListConverter csvParser;
  final Client httpClient;

  static const _baseUri =
      "https://raw.githubusercontent.com/ISKalsi/pretend/main/api";

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

  List<T> _parseCsvData<T>(List<List> data, T Function(List) mapper) {
    final dataWithoutHeading = data.getRange(1, data.length).toList();
    dataWithoutHeading.removeWhere((subject) => subject.length < 2);
    return dataWithoutHeading.map<T>(mapper).toList(growable: false);
  }

  List<SubjectModel> _parseToListOfSubjectModels(List<List> data) {
    return _parseCsvData(
      data,
      (subject) => SubjectModel.fromCsv(subject),
    );
  }

  List<CollegeModel> _parseToListOfCollegeModels(List<List> data) {
    return _parseCsvData(
      data,
      (college) => CollegeModel.fromCsv(college),
    );
  }

  @override
  Future<List<SubjectModel>> getSubjects(String collegeID) async {
    try {
      final uri = "$_baseUri/subjects/$collegeID.csv";
      final csv = await _fetchCsvFile(uri);
      final data = csvParser.convert(csv);
      return _parseToListOfSubjectModels(data);
    } on ClientException {
      throw ServerException();
    } on NoRemoteDataException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<List<CollegeModel>> getColleges() async {
    try {
      final uri = "$_baseUri/colleges.csv";
      final csv = await _fetchCsvFile(uri);
      final data = csvParser.convert(csv);
      return _parseToListOfCollegeModels(data);
    } on ClientException {
      throw ServerException();
    } on NoRemoteDataException {
      rethrow;
    } catch (e) {
      throw ServerException();
    }
  }
}
