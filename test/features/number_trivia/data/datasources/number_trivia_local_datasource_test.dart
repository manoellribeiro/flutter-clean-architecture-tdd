import 'dart:convert';

import 'package:clean_architecture_reso/core/error/exceptions.dart';
import 'package:clean_architecture_reso/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture_reso/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main(){
  NumberTriviaLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NumberTriviaLocalDataSourceImpl(sharedPreferences: mockSharedPreferences); 
  });

  group('getLastNumberTrivia' ,(){

    final testNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test(
      'should return NumberTrivia from SharedPreferences when there is one in the cache',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any))
        .thenReturn(fixture('trivia_cached.json'));
        //act
        final result = await dataSource.getLastNumber();
        //assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
        expect(result, equals(testNumberTriviaModel));
      }
    );
    test(
      'should throw CachedExeption when there is not a cached value',
      () async {
        //arrange
        when(mockSharedPreferences.getString(any))
        .thenReturn(null);
        //act
        final call = dataSource.getLastNumber;
        //assert
        expect(() => call(), throwsA(isA<CacheException>()));
      } 
    );


  });    

    group('cacheNumberTrivia', () {

      final testNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test trivia');

      test(
      'should call SharedPreferences to cache the data',
      () async {        
        //act
        dataSource.cacheNumberTrivia(testNumberTriviaModel);
        //assert
        final expectedJsonString = json.encode(testNumberTriviaModel.toJson());
        verify(mockSharedPreferences.setString(CACHED_NUMBER_TRIVIA, expectedJsonString));
      } 
    );
  });
}