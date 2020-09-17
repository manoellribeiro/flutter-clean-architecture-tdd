import 'package:clean_architecture_reso/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumber();
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}