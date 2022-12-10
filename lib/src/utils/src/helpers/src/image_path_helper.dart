extension ImagePath on String {
  String get toSvg => "assets/images/others/$this.svg";
  String get toPng => "assets/images/others/$this.png";
  String get toJpg => "assets/images/others/$this.jpg";
}
