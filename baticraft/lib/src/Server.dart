class Server {
  static String ROUTE = "http://192.168.1.21:8000/";


  static Uri urlLaravel(url) {
    Uri Server = Uri.parse(ROUTE+"api/MobileApi/" + url);
    return Server;
  }
  static String urlLaravelImage(url) {
    String Server = ROUTE+"images/" + url;
    return Server;
  }

  static String urlGambar(url) {
    String Server = "assets/images/" + url;
    return Server;
  }
}


