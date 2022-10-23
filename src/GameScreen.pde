
enum Screen {MENU, USER_CHOICE, COMP_CHOICE};
boolean playing = false;

String[] outputs = {"(too high)", "(correct)", "(too low)"};
String output = "";

int squaresize, x1, x2, y;
int btnx, btny, btnw, btnh;
int nextx, nexty, nextw, nexth;

void initGame() {
  squaresize = width/2 - 30;
  x1 = 20 + squaresize/2;
  x2 = width - 20 - squaresize/2;
  y =  height - squaresize - 20;
  
  btnx = width/2;
  btny = height/2 + height/3;
  btnw = 200;
  btnh = 100;
  
  nextx = width - 50;
  nexty = height - 40;
  nextw = 75;
  nexth = 50;
}

void drawMenu() {
  textSize(60);
  text("Secret Number!", width/2, 32);
  
  textSize(25);
  text("Someone will generate a random number.\nWho will it be?", width/2, 100);
  
  fill(0, 200, 0);
  square(x1, y, squaresize);
  
  fill(200, 0, 0);
  square(x2, y, squaresize);
  
  fill(255);
  textSize(28);
  text("You\npick the number", x1, y);
  text("Computer\npicks the number", x2, y);
}

void userChoice() {
  fill(255);

  textSize(60);
  text("User's Choice", width/2, 32);

  textSize(25);
  text("Enter a number from 1-100 (inclusive)", width/2, 75);
  
  if (!computer.won)
    text(small + " < x < " + big, width/2, 100);
  else
    text("x = " + input.value, width/2, 100);
  
  textSize(28);
  if (playing) {
    if (computer.final_guess <= 0)
      text("Press NEXT to see\nthe computer's guess", width/2, height * 11/12 - 5);
  }

  if (computer.final_guess > 0) {
    text("Computer Guess: " + computer.final_guess + " " + output, width/2, height/2 - input.h * 3/4);
    text("Total guesses: " + computer.total, width/2, height/2 + input.h * 3/4);
  }

  if (computer.won)
    text("Computer won in " + computer.total + " guesses!", width/2, height * 11/12 + 12);
  else if (!playing) {
    text("Smart", nextx - 45, nexty);
    
    noFill();
    stroke(255);
    strokeWeight(5);
    square(nextx + 15, nexty, 25);
    
    stroke(0, 200, 0);
    if (computer.smart) {
      line(nextx + 2, nexty, nextx + 15, nexty + 13);
      line(nextx + 15, nexty + 13, nextx + 28, nexty - 13);
    }
  }
  else {
    noStroke();
    fill(255, 200, 0);
    rect(nextx, nexty, nextw, nexth);
    
    fill(0);
    text("NEXT", nextx, nexty);
  }

}

void computerChoice() {
  fill(255);

  textSize(60);
  text("Computer's Choice", width/2, 32);

  textSize(25);
  text("Guess a number from 1-100 (inclusive)", width/2, 75);
  
  if (!input.won)
    text(small + " < x < " + big, width/2, 100);
  else
    text("x = " + computer.number, width/2, 100);

  text("Total guesses: " + input.total, width/2, height/2 - input.h * 3/4);
  
  if (playing || input.won)
    text(input.txt, width/2, height/2 + input.h * 3/4 + 15);
}

void mouseClicked() {
  if (state == Screen.MENU) {
    if (mouseY > y - squaresize/2 && mouseY < y + squaresize/2) {
      if (mouseX > x1 - squaresize/2 && mouseX < x1 + squaresize/2)
        state = Screen.USER_CHOICE;
      else if (mouseX > x2 - squaresize/2 && mouseX < x2 + squaresize/2)
        state = Screen.COMP_CHOICE;
    }
    return;
  }

  else {
    boolean b = (state == Screen.COMP_CHOICE) ? playing : (!playing && !computer.won);
    input.setActive(b && mouseX > width/2 - input.w/2 && mouseX < width/2 + input.w/2 &&
      mouseY > height/2 - input.h/2 && mouseY < height/2 + input.h/2);

    if (!playing && !computer.won && !input.won &&
      mouseX > width/2 - btnw/2 && mouseX < width/2 + btnw/2 &&
        mouseY > btny - btnh/2 && mouseY < btny + btnh/2) {
          if (state == Screen.USER_CHOICE) input.begin();
          else computer.begin();
      }
  }
  
  if (state == Screen.USER_CHOICE) {
    if (playing && !computer.won &&
      mouseX > nextx - nextw/2 && mouseX < nextx + nextw/2 &&
        mouseY > nexty - nexth/2 && mouseY < nexty + nexth/2) {
          Integer a = input.getInt();
          Integer b = computer.guess();
          updateNumbers(a, b);
          output = outputs[a.compareTo(b) + 1];
        }

    // nextx + 15, nexty
    if (!playing && mouseX > nextx + 2 && mouseX < nextx + 16 &&
      mouseY > nexty - 13 && mouseY < nexty + 13)
        computer.smart = !computer.smart;
  }

  if (dist(mouseX, mouseY, 50, height-50) < 35) {
    state = Screen.MENU;

    input.reset();
    computer.reset();

    playing = false;
    output = "";
    small = 0;
    big = 101;
  }
}

void keyPressed() {
  if (state != Screen.MENU && input.active)
    input.updateValue();

  if (playing && state == Screen.COMP_CHOICE && keyCode == ENTER)
    input.acceptGuess();
}
