class ApiUrlConstants{

  // Credentials
  static const String API_KEY = 'c3c1473729ac9178636ca2a4562b15bf';
  static const String API_READ_ACCESS_TOKEN = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjM2MxNDczNzI5YWM5MTc4NjM2Y2EyYTQ1NjJiMTViZiIsInN1YiI6IjY0ODQ4N2IzYmYzMWYyNTA1NWEwYzExNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.XTdit98nrJfd2Trzu3bZiqP4gG3g5V6KCpYIWOUiZ4M';

  // Base URL
  static const String BaseUrl = "https://api.themoviedb.org/3";

  // End points
  static const String endPointUpComingMovies = "/movie/upcoming";
  static const String endPointConfiguration = "/configuration";
  static const String genres = "/genre/movie/list?language=en";
  static const String individualMovie = "/movie/";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 60);

  // connectTimeout
  static const Duration connectTimeout = Duration(seconds: 60);
}