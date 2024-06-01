enum Routes {
  splash,
  login,
  layout,
  users,
  info,
  createOrder;

  String get path => '/${name.toString()}';
}
