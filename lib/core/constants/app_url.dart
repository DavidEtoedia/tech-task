class AppUrl {
  static const baseUrl =
      "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev";
  static const ingredient = "/ingredients";
  static const recipe = "/recipes";
  static String queryParam(int offset) => 'pokemon/?limit=20&offset=$offset';
}
