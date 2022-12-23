class player{
  //each player will have an x position and y position, as well as an x and y speed. They also get a double-jump variable that checks if they have double-jumped.
  float x,y,xSpeed,ySpeed,dashXSpeed,dashYSpeed;
  int score;
  boolean doubleJumpable;
  //the state of the player, i.e. "falling" or "grounded" so we can have different things happen for each state.
  String state;
  color playerColor, glint, glint1, glint2, glint3, glint4, glint5, glint6, glint7;//defines the varying shades of the glint on the marbles
  int dashing;
  
  //initiallizes the player at a certain coordinate. Each player spawns with no speed and a state of "falling."
  player(float xPos,float yPos, color playerColor, color glint, color glint1, color glint2, color glint3, color glint4, color glint5, color glint6, color glint7){
    x=xPos;y=yPos;xSpeed = 0;ySpeed = 0;score=0;
    state = "falling";
    colliding = false;
    dashing = 0;
    this.playerColor = playerColor;
    this.glint = glint;
    this.glint1 = glint1;
    this.glint2 = glint2;
    this.glint3 = glint3;
    this.glint4 = glint4;
    this.glint5 = glint5;
    this.glint6 = glint6;
    this.glint7 = glint7;
  }
  
  //this is what the marbles look like
  void display(){
   stroke(playerColor);
    fill(playerColor);
    ellipse(x, y, 60, 60);
    
    stroke(glint);
    fill(glint);
    ellipse(x + 12, y - 12, 21, 21);
    
    stroke(glint1);
    fill(glint1);
    ellipse(x + 12, y - 12, 18, 18);
    
    stroke(glint2);
    fill(glint2);
    ellipse(x + 12, y - 12, 15, 15);
    
    stroke(glint3);
    fill(glint3);
    ellipse(x + 12, y - 12, 12, 12);
    
    stroke(glint4);
    fill(glint4);
    ellipse(x + 12, y - 12, 9, 9);
    
    stroke(glint5);
    fill(glint5);
    ellipse(x + 12, y - 12, 6, 6);
    
    stroke(glint6);
    fill(glint6);
    ellipse(x + 12, y - 12, 3, 3);
    
    stroke(glint7);
    fill(glint7);
    ellipse(x + 12, y - 12, 2, 1);
  }
  
  //this is the movement of the player
  void move(boolean left,boolean right,boolean up,boolean doubleJump){//when calling the movement, you need to define what keys are being pressed
    
    //if the player is falling, then this is what the movement looks like
    if(state == "falling"){
      if(left){xSpeed -= .2;if(xSpeed <= -3){xSpeed = -3;}}//press left to accelerate left (maximum speed is -15)
      if(right){xSpeed += .2;if(xSpeed >= 3){xSpeed = 3;}}//and press right to go right (maximum speed is 15)
      if(up && doubleJumpable && doubleJump){ySpeed = -2.5;doubleJumpable = false;}//if the player has a double-jump and they press "up", then they will jump again in the air.
      ySpeed += .1; //they accelerate downwards
    }    
    
    //if the player is on the ground, then this is the movement
    if(state == "grounded"){
      if(left){xSpeed -= .5;if(xSpeed <= -3){xSpeed = -3;}}//press left to accelerate left (maximum speed is -15)
      if(right){xSpeed += .5;if(xSpeed >= 3){xSpeed = 3;}}//and press right to go right (maximum speed is 15)
      if(!left && !right && xSpeed != 0){xSpeed /= 1.15;if(abs(xSpeed) <= .1){xSpeed = 0;}}//slow down if no keys are being pressed
      if(up){ySpeed = -3;state = "falling";}//and jump if "up" is pressed
    }
    
    //if the player is bouncing, then this is what they do
    if(state == "bouncing"){
      if(left){xSpeed -= .2;if(xSpeed <= -3){xSpeed = -3;}}//press left to accelerate left (maximum speed is -15)
      if(right){xSpeed += .2;if(xSpeed >= 3){xSpeed = 3;}}//and press right to go right (maximum speed is 15)
      if(up){ySpeed = -3;state = "falling";}//and jump if "up" is pressed
      ySpeed += .1; //they accelerate downwards
    }

if(player1.y > height && ending == false){
  ending = true;
  player2.score++;
}
if(player2.y > height &&  ending == false){
  ending = true;
  player1.score++;
}
}
}
