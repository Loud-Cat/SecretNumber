
class Computer {
  int total;
  int final_guess;
  int number;
  
  boolean won;
  boolean smart;
  
  Computer() {
    reset();
  }
  
  void reset() {
    total = 0;
    
    final_guess = 0;
    number = -1;
    
    won = false;
    smart = false;
  }
  
  void begin() {
    number = (int) random(small  + 1, big);
    playing = true;
  }
  
  int guess() {
    if (!playing) return -2;
    
    int out = smart ? small + (big - small)/2 : (int) random(small + 1, big);
    
    total += 1;
    if (out == input.getInt())
      win();
    
    final_guess = out;
    return out;
  }
  
  void win() {
    playing = false;
    won = true;
  }
}
