import 'package:dio/dio.dart';

const baseUrl = 'https://api.nasa.gov/';
const endPoint = 'planetary/apod?';
const apiKey = 'api_key=46gbrwXgdBYvqEH2hsN0cXFXYsp3aa1ydxLACElF';

// TODO(add): добавить возможность получения определенной даты в запрос.
class PictureOfTheDayApiProvider {
  Future<dynamic> getPictures() async {
    final response = await Dio().get<dynamic>(
      '$baseUrl$endPoint$apiKey&start_date=2024-1-26',
    );
    return response.data;
  }
}
