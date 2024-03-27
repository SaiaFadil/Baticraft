class Server {
  static Uri url(url) {
    Uri Server = Uri.parse("http://172.17.202.43/Baticraft/baticraft/fh_db/" + url);
    return Server;
  }

  static String urlGambar(url) {
    String Server = "assets/images/" + url;
    return Server;
  }
}
