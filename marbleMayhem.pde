//Samuel  Hiebert, Brian Haacke, Luke Dutson. 8 February 2021, Final Project

import processing.sound.*;
boolean left1, right1, up1, down1, left2, right2, up2, down2, doubleJump1, doubleJump2, colliding;
int numCollisionChecks;
float platformX;
float platformY; 
float platformB;
float platformH;
float h = -50;
PFont font;
float loopRpt;
boolean ending = false;
boolean start = true;
color rectColor, rectHover, baseColor;
SoundFile marbleGround, marbleMarble;
boolean pause = false;
boolean space = false;
boolean mouse = false;

player player1 = new player(600,500,color(0),color(30),color(35),color(45),color(55),color(65),color(75),color(85),color(95));
player player2 = new player(1320,500,color(200),color(205),color(210),color(215),color(220),color(230),color(240),color(245),color(255));


//when the selected keys are pressed the player will move, otherwise they won't
void keyPressed() {
  //player 1
  if(key == 'a' || key == 'A') {left1 = true;}
  if(key == 'd' || key == 'D') {right1 = true;}
  if(key == 'w' || key == 'W') {up1 = true;}
  if(key == 's' || key == 'S') {down1 = true;}
  //player 2
  if(keyCode == LEFT) {left2 = true;}
  if(keyCode == RIGHT) {right2 = true;}
  if(keyCode == UP) {up2 = true;}
  if(keyCode == DOWN) {down2 = true;}
  
  if(keyCode == ' '){space = true;}
}

void keyReleased() {
  //player 1
  if(key == 'a' || key == 'A') {left1 = false;}
  if(key == 'd' || key == 'D') {right1 = false;}
  if(key == 'w' || key == 'W') {up1 = false;doubleJump1 = true;}
  if(key == 's' || key == 'S') {down1 = false;}
  //player 2
  if(keyCode == LEFT) {left2 = false;}
  if(keyCode == RIGHT) {right2 = false;}
  if(keyCode == UP) {up2 = false;doubleJump2 = true;}
  if(keyCode == DOWN) {down2 = false;}

  if(keyCode == ' '){space = false;}
}

void mousePressed(){
  mouse = true;
}
void mouseReleased(){
  mouse = false;
}


void setup(){
  //size(1900,1000);
  fullScreen();
  surface.setResizable(true);
  platformX = width/2 - 400;
  platformY = height/2 + 125; 
  platformB = 1000;
  platformH = height/2;
  player1.x = width/2 - 300;
  player1.y = height/2 + 90;
  player2.x = width/2 + 300;
  player2.y = height/2 + 90;
  noStroke();
  font = createFont("VT323-Regular.ttf", 180);
  rectColor = color(155);
  rectHover = color(100);
  baseColor = color(102);
  marbleMarble = new SoundFile(this,"marbleMarble.wav");
  marbleGround = new SoundFile(this,"marbleGround.wav");
}

void platform(float stageX,float stageY,float stageB,float stageH){
  noStroke();
  rect(stageX,stageY,stageB,stageH,12.5);
  if(player1.x >= stageX && player1.x <= stageX+stageB){
    //ground collision
    if(player1.y+31 >= stageY && player1.y-31 < stageY){//if the player is below the ground, and also high enough to be colliding with the ground, then
      if(abs(player1.ySpeed) < .1){player1.y = stageY-31;if(player1.state == "bouncing"){marbleGround.amp(player1.ySpeed/5);marbleGround.jump(0);}player1.ySpeed = 0;player1.state = "grounded";player1.doubleJumpable = true;colliding = true;}//land if the ySpeed is low, otherwise
      else{player1.y = stageY-31;marbleGround.amp(player1.ySpeed/5);marbleGround.jump(0);player1.state = "bouncing";player1.ySpeed = -player1.ySpeed/3;player1.doubleJumpable = true;colliding = true;if(!left1 && !right1 && player1.xSpeed != 0){player1.xSpeed = player1.xSpeed/3;}}//bounce
    }
    //bottom collision
    if(player1.y-31 <= stageY+stageH && player1.y+31 >= stageY+stageH){//if the player is above the bottom, and also low enough to be colliding with the bottom, then
      player1.y = stageY+stageH+31;player1.ySpeed = -player1.ySpeed/3;colliding = true; //push it down and bounce it off the bottom, but also give it a double-jump
      if(!left1 && !right1 && player1.xSpeed != 0){player1.xSpeed = player1.xSpeed;} //if left/right aren't being pressed, then reduce the xSpeed as well
    }
  }
  //side collisions
  if(player1.y >= stageY && player1.y <= stageY+stageH){
    if(player1.x-31 <= stageX+stageB && player1.x+31 >= stageX+stageB){
      player1.x = stageX+stageB+31;player1.xSpeed = -player1.xSpeed/3;colliding = true;
    }
    if(player1.x+31 >= stageX && player1.x-31 <= stageX){
      player1.x = stageX-31;player1.xSpeed = -player1.xSpeed/3;colliding = true;
    }
  }
  
  if(player2.x >= stageX && player2.x <= stageX+stageB){
    //ground collision
    if(player2.y+31 >= stageY && player2.y-31 < stageY){//if the player is below the ground, and also high enough to be colliding with the ground, then
      if(abs(player2.ySpeed) < .1){player2.y = stageY-31;if(player2.state == "bouncing"){marbleGround.amp(player2.ySpeed/5);marbleGround.jump(0);}player2.ySpeed = 0;player2.state = "grounded";player2.doubleJumpable = true;colliding = true;}//land if the ySpeed is low, otherwise
      else{player2.y = stageY-31;marbleGround.amp(player2.ySpeed/5);marbleGround.jump(0);player2.state = "bouncing";player2.ySpeed = -player2.ySpeed/3;player2.doubleJumpable = true;colliding = true;if(!left2 && !right2 && player2.xSpeed != 0){player2.xSpeed = player2.xSpeed/3;}}//bounce
    }
    //bottom collision
    if(player2.y-31 <= stageY+stageH && player2.y+31 >= stageY+stageH){//if the player is above the bottom, and also low enough to be colliding with the bottom, then
      player2.y = stageY+stageH+31;player2.ySpeed = -player2.ySpeed/3;colliding = true; //push it down and bounce it off the bottom, but also give it a double-jump
      if(!left1 && !right1 && player2.xSpeed != 0){player2.xSpeed = player2.xSpeed/3;} //if left/right aren't being pressed, then reduce the xSpeed as well
    }
  }
  //side collisions
  if(player2.y >= stageY && player2.y <= stageY+stageH){
    if(player2.x-31 <= stageX+stageB && player2.x+31 >= stageX+stageB){
      player2.x = stageX+stageB+31;player2.xSpeed = -player2.xSpeed/3;colliding = true;
    }
    if(player2.x+31 >= stageX && player2.x-31 <= stageX){
      player2.x = stageX-31;player2.xSpeed = -player2.xSpeed/3;colliding = true;
    }
  }

}


void draw(){
  if(start){
  gameMenu();
  }
  else{
  if(!ending){
  gameplay();
  }
  if(ending){
    endScreen();
  }
  }
}

void gameMenu(){
   player1.score = 0;
   player2.score = 0;
   noStroke();
   fill(0);
   rect(0,0,width/2,height);
   fill(255);
   rect(width/2,0,width/2,height);
   fill(255);
   textFont(font);
   textAlign(CENTER);
   textSize(180);
   text("MARBLE", width/2 - 275, height/2 - 100);
   fill(0);
   text("MAYHEM!", width/2 + 313, height/2 - 100);
     
   if (overRect()) {
     fill(rectHover);
     rect(width/2 - 150, height/2 + 100, 300, 125,2);    
     fill(255);
     textSize(50);
     text("START", width/2, height/2 + 177);
   } else {
     fill(rectColor);
     rect(width/2 - 150, height/2 + 100, 300, 125,2);    
     fill(0);
     textSize(50);
     text("START", width/2, height/2 + 177);
   }
   
   if (gameExit()) {
     fill(rectHover);
     rect(width - 375, height - 125, 300, 60, 2);    
     fill(255);
     textSize(50);
     text("Quit Game", width - 225, height - 80);
   } else {
     fill(rectColor);
     rect(width - 375, height - 125, 300, 60,2);    
     fill(0);
     textSize(50);
     text("Quit Game", width - 225, height - 80);
   }
   
   if (gameControls()) {
     fill(rectHover);
     rect(width - 375, height - 220, 300, 60,2);    
     fill(255);
     text("Game Controls", width - 225, height - 178);
     textSize(40);
     fill(0);
     text("Black Player - Use WASD\nWhite Player - Use Arrow Keys\nTo pause press Space", width - 295, height - 370);
   } else {
     fill(rectColor);
     rect(width - 375, height - 220, 300, 60,2);    
     fill(0);
     textSize(50);
     text("Game Controls", width - 225, height - 178);
   }
   
   if (credits()) {
     fill(rectHover);
     rect(75, height - 125, 300, 60, 2);    
     fill(255);
     text("Game Credits", 225, height - 83);
     textSize(40);
     fill(255);
     text("Made by\nBrian \"KRoD\" Haacke\nLuke Dutson\nSam Hiebert",225, height - 330);
   } else {
     fill(rectColor);
     rect(75, height - 125, 300, 60, 2);    
     fill(0);
     textSize(50);
     text("Game Credits", 225, height - 83);
   }

  if(mouse && overRect()){
    initialPos();
    start = false;
    ending = false;
  }
  
  if(mouse && gameExit()){
    exit();
  }
}

boolean overRect()  {
  if (mouseX >= width/2 - 150 && mouseX <= width/2 + 150 && 
      mouseY >= height/2 + 100 && mouseY <= height/2 + 225) {
    return true;
  } else {
    return false;
  }
}

boolean contButton(){
  if(mouseX <width/2 + 200 && mouseX > width/2 - 200
   && mouseY > height/2 - 30 && mouseY < height/2 + 20){
   return true;
}else{
  return false;}
}
 
boolean quitButton(){
  if(mouseX <width/2 + 200 && mouseX > width/2 - 200
   && mouseY > height/2 + 45 && mouseY < height/2 + 95){
   return true;
}else{
  return false;}
}
//width - 375, height - 125, 300, 60
boolean gameExit(){
  if(mouseX > width - 375 && mouseX < width -75
&& mouseY > height - 125 && mouseY < height - 65){return true;}
  else{
   return false; 
  }
}

boolean gameControls(){
  if(mouseX > width - 375 && mouseX < width -75
&& mouseY > height - 220 && mouseY < height - 160){return true;}
  else{
   return false; 
  }
}
//width/2 - 150,height/2 + 250, 300, 50
boolean endQuit(){
  if(mouseX <width/2 + 150 && mouseX > width/2 - 150
   && mouseY > height/2 +250 && mouseY < height/2 + 300){
   return true;
}else{
  return false;}
}

boolean credits(){
  if(mouseX > 75 && mouseX < 375
&& mouseY > height - 125 && mouseY < height - 65){return true;}
  else{
   return false; 
  }
}
 

void endScreen(){
  marbleMarble.stop();
  marbleGround.stop();
  noStroke();
  if(player1.y > height){
     fill(250);
     rect(0,0,width +5,height + 5, 2);
     fill(230,50,50);
     textFont(font);
     textAlign(CENTER);
     textSize(200);
     text("GAME OVER!", width/2, height/2 - 200); 
     textSize(100);
     fill(0);
     text(player1.score, 120, 120);
     fill(200);
     text(player2.score, width -  120, 120);
     fill(0);
     text("WHITE WINS!", width/2, height/2);
     
    if(endQuit()){
     textSize(50);
     fill(rectHover);
     rect(width/2 - 150,height/2 + 250, 300, 50, 2);
     fill(255);
     text("Quit to Menu", width/2, height/2 + 290);
    }else{
     textSize(50);
     fill(rectColor);
     rect(width/2 - 150,height/2 + 250, 300, 50);
     fill(0);
     text("Quit to Menu", width/2, height/2 + 290);}
     
     if (overRect()) {
     fill(rectHover);
     rect(width/2 - 150, height/2 + 100, 300, 125, 2);    
     fill(255);
     textSize(50);
     text("PLAY AGAIN", width/2, height/2 + 155);
     textSize(40);
     text("(press ENTER)",width/2, height/2 + 200);
   } else {
     fill(rectColor);
     rect(width/2 - 150, height/2 + 100, 300, 125, 2);    
     fill(0);
     textSize(50);
     text("PLAY AGAIN", width/2, height/2 + 155);
     textSize(40);
     text("(press ENTER)",width/2, height/2 + 200);
   }
  if((mouse && overRect()) || (keyCode == 10)){
    initialPos();
    ending = false;
    keyCode = 0;
  }
  
  if(mousePressed && endQuit()){
   ending = false;
   start = true; 
  }
     
   }else{
     fill(0);
     rect(0,0,width +5,height + 5, 2);
     fill(230,50,50);
     textFont(font);
     textAlign(CENTER);
     text("GAME OVER!", width/2, height/2 - 200); 
     textSize(100);
     fill(100);
     text(player1.score, 120, 120);
     fill(200);
     text(player2.score, width -  120, 120);
     fill(255);
     text("BLACK WINS!", width/2, height/2);
     
     if(endQuit()){
      textSize(50);
     fill(rectHover);
     rect(width/2 - 150,height/2 + 250, 300, 50, 2);
     fill(255);
     text("Quit to Menu", width/2, height/2 + 290);
    }else{
     textSize(50);
     fill(rectColor);
     rect(width/2 - 150,height/2 + 250, 300, 50 ,2);
     fill(0);
     text("Quit to Menu", width/2, height/2 + 290);}
     
   if (overRect()) {
     fill(rectHover);
     rect(width/2 - 150, height/2 + 100, 300, 125, 2);    
     fill(255);
     textSize(50);
     text("PLAY AGAIN", width/2, height/2 + 155);
     textSize(40);
     text("(press ENTER)",width/2, height/2 + 200);
   } else {
     fill(rectColor);
     rect(width/2 - 150, height/2 + 100, 300, 125, 2);    
     fill(0);
     textSize(50);
     text("PLAY AGAIN", width/2, height/2 + 155);
     textSize(40);
     text("(press ENTER)",width/2, height/2 + 200);
   }
  if((mouse && overRect()) || (keyCode == 10)){
    initialPos();
    ending = false;
    keyCode = 0;
  }
    if(mousePressed && endQuit()){
   ending = false;
   start = true; 
  }
   }
}
  
  void initialPos(){
    platformX = width/2 - 400;
    platformB = 800;
    player1.x = width/2 - 300;
    player1.y = height/2 + 90;
    player2.x = width/2 + 300;
    player2.y = height/2 + 90;
    player1.xSpeed = 0;
    player1.ySpeed = 0;
    player2.xSpeed = 0;
    player2.ySpeed = 0;
    pause = false;
  }
  
  
void gameplay(){
  if(pause){ //pause screen, only during gameplay()
   fill(230,50,50);
   textFont(font);
   textAlign(CENTER);
   textSize(200);
   text("PAUSE", width/2, height/2 - 100);
   textSize(60);
   
   if(contButton()){
     fill(rectHover);
     rect(width/2 - 200,height/2 - 30, 400, 50 ,2);
     fill(255);
     text("Continue", width/2, height/2 + 10);
   }else{
     fill(rectColor);
     rect(width/2 - 200,height/2 - 30, 400, 50,2);
     fill(0);
     text("Continue", width/2, height/2 + 10);
   }
   
   if(quitButton()){
     fill(rectHover);
     rect(width/2 - 200,height/2 + 45, 400, 50,2);
     fill(255);
     text("Quit to Menu", width/2, height/2 + 85);
    }else{
     fill(rectColor);
     rect(width/2 - 200,height/2 + 45, 400, 50,2);
     fill(0);
     text("Quit to Menu", width/2, height/2 + 85);}
     
  if(mouse && contButton()){
    pause = false;
  }
  if(mouse && quitButton()  ){
    start = true;
    mouse = false;
  }
}
  else{ 
  if(space){space = false;pause = true;}
  background(100, 170, 255);
  fill(200);
  player1.display();
  player1.move(left1,right1,up1,doubleJump1);
  player2.display();
  player2.move(left2,right2,up2,doubleJump2);
  if(player1.state != "bouncing"){player1.state = "falling";}
  if(player2.state != "bouncing"){player2.state = "falling";}
    //in order to accurately detect collisions, the game will do 4 collision checks per frame
  numCollisionChecks = 4;
  while(!colliding || numCollisionChecks > 0){
      
    //the player moves according to their speed
    player1.x+=player1.xSpeed;player1.y+=player1.ySpeed;
    player2.x+=player2.xSpeed;player2.y+=player2.ySpeed;
    
  textSize(100);
  fill(0);
  text(player1.score, 120, 120);
  fill(200);
  text(player2.score, width -  120, 120);
  if(platformB > 600){
    fill(200);
  }else if(platformB > 350){
  fill(200 * (platformB - 350)/250);
  }else{fill(0);}
  platform(platformX, platformY, platformB, platformH);
  if(platformX < width/2 - 25){
  platformX += .025;
  platformB -= .05;
  //platformColor -=.0;
  }
  
  
    
    if((player1.x-player2.x)*(player1.x-player2.x) + (player1.y-player2.y)*(player1.y-player2.y) <= 3600){//if the players are colliding (aka their centers are too close)
    PVector position1 = new PVector(player1.x,player1.y);
    PVector position2 = new PVector(player2.x,player2.y);
    PVector velocity1 = new PVector(player1.xSpeed,player1.ySpeed);
    PVector velocity2 = new PVector(player2.xSpeed,player2.ySpeed);
    
    // Get distances between the balls components
    PVector distanceVect = PVector.sub(position1, position2);

    // Calculate magnitude of the vector separating the balls
    float distanceVectMag = distanceVect.mag();

    // Minimum distance before they are touching
    float minDistance = 60;

    if (distanceVectMag < minDistance) {
      float distanceCorrection = (minDistance-distanceVectMag)/2.0;
      PVector d = distanceVect.copy();
      PVector correctionVector = d.normalize().mult(distanceCorrection);
      position1.add(correctionVector);
      position2.sub(correctionVector);

      // get angle of distanceVect
      float theta  = distanceVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);

      /* bTemp will hold rotated ball positions. You 
       just need to worry about bTemp[1] position*/
      PVector[] bTemp = {
        new PVector(), new PVector()
      };

      /* this ball's position is relative to the other
       so you can use the vector between them (bVect) as the 
       reference point in the rotation expressions.
       bTemp[0].position2.x and bTemp[0].position2.y will initialize
       automatically to 0.0, which is what you want
       since b[1] will rotate around b[0] */
      bTemp[1].x  = cosine * distanceVect.x + sine * distanceVect.y;
      bTemp[1].y  = cosine * distanceVect.y - sine * distanceVect.x;

      // rotate Temporary velocities
      PVector[] vTemp = {
        new PVector(), new PVector()
      };

      vTemp[0].x  = cosine * velocity2.x + sine * velocity2.y;
      vTemp[0].y  = cosine * velocity2.y - sine * velocity2.x;
      vTemp[1].x  = cosine * velocity1.x + sine * velocity1.y;
      vTemp[1].y  = cosine * velocity1.y - sine * velocity1.x;

      /* Now that velocities are rotated, you can use 1D
       conservation of momentum equations to calculate 
       the final velocity along the x-axis. */
      PVector[] vFinal = {  
        new PVector(), new PVector()
      };

      // final rotated velocity for b[0]
      vFinal[1].x = 1.5*vTemp[0].x;
      vFinal[0].y = vTemp[0].y;

      // final rotated velocity for b[0]
      vFinal[0].x = 1.5*vTemp[1].x;
      vFinal[1].y = vTemp[1].y;

      marbleMarble.amp(abs(vTemp[0].x - vTemp[1].x)/6);marbleMarble.jump(0);

      // hack to avoid clumping
      while((player1.x-player2.x)*(player1.x-player2.x) + (player1.y-player2.y)*(player1.y-player2.y) <= 3600){player1.x -= player1.xSpeed/4;player1.y -= player1.ySpeed/4;player2.x -= player2.xSpeed/4;player2.y -= player2.ySpeed/4;}

      /* Rotate ball positions and velocities back
       Reverse signs in trig expressions to rotate 
       in the opposite direction */
      // rotate balls
      PVector[] bFinal = { 
        new PVector(), new PVector()
      };

      bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      // update balls to screen position
      position1.x = position2.x + bFinal[1].x;
      position1.y = position2.y + bFinal[1].y;

      position2.add(bFinal[0]);
      position1.add(bFinal[1]);

      // update velocities
      velocity2.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity2.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      velocity1.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      velocity1.y = cosine * vFinal[1].y + sine * vFinal[1].x;
      
      player1.xSpeed = velocity1.x;
      player1.ySpeed = velocity1.y;
      player2.xSpeed = velocity2.x;
      player2.ySpeed = velocity2.y;
      if(player1.state == "grounded"){player1.state = "bouncing";player1.ySpeed = -abs(player1.xSpeed/2);}
      if(player2.state == "grounded"){player2.state = "bouncing";player2.ySpeed = -abs(player2.xSpeed/2);}

    }
 
    player1.x+=player1.xSpeed;player1.y+=player1.ySpeed;
    player2.x+=player2.xSpeed;player2.y+=player2.ySpeed;
      
      
    }

    
    numCollisionChecks--;
  
  }
  doubleJump1 = !up1;
  doubleJump2 = !up2;
}  
}
