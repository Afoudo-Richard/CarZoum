class Toilet {
  int height = 3;
  int width = 4;
  int numGoToToilet = 4;
  Bowl bowl = Bowl();
}

class Bowl {
  int height = 3;
  int width = 4;
  int numOfPeopleWhoWashedTheirHands = 8;
}

class BathRoom {
  Toilet toilet = new Toilet();
  Bowl bowl = new Bowl();

  void record() {
    print("${toilet.numGoToToilet}");
    print("${bowl.numOfPeopleWhoWashedTheirHands}");
  }
}

void main() {
  BathRoom bathRoom = BathRoom();

  bathRoom.record();
}
