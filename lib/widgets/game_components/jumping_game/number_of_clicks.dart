class NumberOfClicks {
  int clicks = 0;
  void addClick() {
    print("CLICKED");
    clicks++;
    print("Number of clicks: " + clicks.toString());
  }
}
