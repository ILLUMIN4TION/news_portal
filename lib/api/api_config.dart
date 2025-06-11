class ApiConfig {
  static const String baseUrl = 'https://daelim-server.fleecy.dev';
  static const String funcUrl = '$baseUrl/functions/v1';

  static final auth = (
    login: '$funcUrl/auth/get-token', //
  );
  static final news = (
    getTopic: '$funcUrl/news/topic',
    getIssue: '$funcUrl/news/issue',
  );
}
