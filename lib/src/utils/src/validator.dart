String? validation(List validators) {
  String? erroMessage;
  for (var item in validators) {
    if (item['validator'] == false) {
      erroMessage = item['errorMessage'];
      break;
    }
  }

  return erroMessage;
}
