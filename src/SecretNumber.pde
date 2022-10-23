/** SecretNumber
  * This program was inspired by an activity in my sign language class
  * where one student picks a random number and classmates guess its value
  **/

int small = 0, big = 101;

PFont title;
Screen state;

Input input;
Computer computer;

void setup() {
  size(500, 500);
  surface.setLocation(displayWidth/2 - width/2, displayHeight/2 - height/2);
  
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  ellipseMode(RADIUS);
  
  title = createFont("SecularOne-Regular.ttf", 128);
  textFont(title);
  state = Screen.MENU;
  
  input = new Input();
  computer = new Computer();
  
  initGame();
}

void draw() {
  background(0);
  noStroke();

  fill(255);
  if (state == Screen.USER_CHOICE) userChoice();
  if (state == Screen.COMP_CHOICE) computerChoice();
  
  if (state == Screen.MENU) drawMenu();
  else {
    noStroke();
    fill(255, 200, 0);
    circle(50, height - 50, 35);
    
    fill(0);
    textSize(65);
    text("<", 50, height - 65);
    
    input.display();
  }
  
  if (mousePressed) {
    noStroke();
    fill(0, 255, 255);
    circle(mouseX, mouseY, 5);
  }
}

void updateNumbers(int number, int comparison) {
  if (comparison > number) big = min(big, comparison);
  if (comparison < number) small = max(small, comparison);
}

boolean isValid(int i) {
  return i > small && i < big;
}
