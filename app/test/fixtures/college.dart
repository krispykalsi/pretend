import 'package:pretend/data/models/college_model.dart';
import 'package:pretend/domain/entities/college.dart';

const _tCollege = College(
  "1",
  "Delhi Technological University",
  "Rohini",
);

const _tCollegeModel = CollegeModel(
  "1",
  "Delhi Technological University",
  "Rohini",
);

College get getTestCollege => _tCollege;

CollegeModel get getTestCollegeModel => _tCollegeModel;
