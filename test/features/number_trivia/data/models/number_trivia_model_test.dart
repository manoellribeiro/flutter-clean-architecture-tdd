import 'dart:convert';

import 'package:clean_architecture_reso/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture_reso/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  final testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a subclass of NumberTrivia entity',
    () async {
      expect(testNumberTriviaModel, isA<NumberTrivia>());
    }
  );

  group("fromJson", (){
    test(
    'should return valid model when the JSON number is an integer',
    () async {
      //arange
      final Map<String, dynamic> jsonMap =
       json.decode(fixture('trivia.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, equals(testNumberTriviaModel));
    }
  );
    test(
    'should return valid model when the JSON number is regarded as a double',
    () async {
      //arange
      final Map<String, dynamic> jsonMap =
       json.decode(fixture('trivia_double.json'));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, equals(testNumberTriviaModel));
    }
  );
  });

  group('toJson', (){
    test(
    'should return aSON map containing the proper data',
    () async {
      //act
      final result = testNumberTriviaModel.toJson();
      //assert

      final expectedMap = {
        "text": "Test Text",
        "number": 1,
      };
      expect(result, expectedMap);
    }
  );
  });

}