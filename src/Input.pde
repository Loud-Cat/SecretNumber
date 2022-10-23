
class Input {  
  int w, h;

  String value;
  boolean active;
  int number;
  
  int total;
  boolean won;
  
  String txt;
  
  Input() {
    w = width * 3/4;
    h = w * 1/3;
    reset();
  }

  void reset() {
    value = "";
    active = false;
    number = -1;
    
    total = 0;

    won = false;
    
    txt = "Go on, take a guess!\n(Press ENTER to submit)";
  }

  void begin() {
    if (value.matches("100|\\d{1,2}")) {
      playing = true;
    }
  }
  
  void acceptGuess() {
    int num = getInt();
    
    if (num == -1) return;
    
    if ( !isValid(num) ) {
      txt = "That number isn't within range";
      return;
    }
    
    txt = "Please enter a valid input";
    total++;
    
    Integer a = computer.number;
    Integer b = num;
    updateNumbers(a, b);

    if (a > b) txt = "Incorrect. The number is greater than " + b;
    else if (a < b) txt = "Incorrect. The number is less than " + b;
    else win();
  }
  
  void win() {
    txt = "Correct! the number was: " + value + "\nYou guessed correctly in " + total + " guesses!";
    playing = false;
    won = true;
    active = false;
  }

  void display() {
    fill(255);
    strokeWeight(10);
    
    if (this.active) stroke(255, 200, 0);
    else stroke(128);
    
    rect(width/2, height/2, w, h);

    if (value.isEmpty() && !(state == Screen.COMP_CHOICE && !playing)) {
      fill(128);
      textSize(30);
      text("Enter a number here", width/2, height/2);
    }
    
    fill(0);
    textSize(65);
    text(value, width/2, height/2);
    
    if (!playing && !computer.won && !won) {
      noStroke();
      fill(0, 200, 0);
      rect(width/2, height/2 + height/3, 200, 100);
      
      fill(0);
      textSize(55);
      String s = state == Screen.USER_CHOICE ? "SUBMIT" : "START";
      text(s, width/2, height/2 + height/3);
    }
  }
  
  int getInt() {
    return value.matches("100|\\d{1,2}") ? Integer.parseInt(value) : -1;
  }
  
  void updateValue() {
    if (keyCode == BACKSPACE && value.length() > 0)
      value = value.substring(0, value.length()-1);

    if ("1234567890".indexOf(key) == -1)
      return;

    else if (keyCode != BACKSPACE && value.length() < 3) {
      if (!(value+key).matches("100|\\d{1,2}"))
        return;

      if ( !(value.length() == 0 && key == '0') )
        value = value + key;
    }
  }

}
