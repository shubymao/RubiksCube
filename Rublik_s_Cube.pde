int n = 3;
int size = 400;
int wid = size/n;
float weight = max(1,wid/20);
float speed = PI/10;
cube c;
void setup(){
 size(1000,1000, P3D);
 frameRate(60);
 c = new cube();
}

void draw(){
  background(255);
  translate(500,500,0);
  pushMatrix();
  rotateX(-PI/6);
  rotateY(5*PI/6);
  c.show();
  c.update();
  popMatrix();
}
void keyPressed(){
  if(n==3){
    switch(key){
      case 'r':
        c.turn(0,0,true);
        break;
      case 'R':
        c.turn(0,0,false);
        break;
      case 'u':
        c.turn(1,0,true);
        break;
      case 'U':
        c.turn(1,0,false);
        break;
      case 'l':
        c.turn(0,2,false);
        break;
     case 'L':
        c.turn(0,2,true);
        break;
     case 'f':
        c.turn(2,0,false);
        break;
     case 'F':
        c.turn(2,0,true);
        break;
     case 'b':
        c.turn(1,2,false);
        break;
     case 'B': 
        c.turn(1,2,true);
        break;
    }
  }
  if(key ==  ' ')c.scramble(50);
  switch(keyCode) {
  case RIGHT:
      c.rotate(1,true);
    break;
  case LEFT:
      c.rotate(1,false);
      break;
  case UP:
    c.rotate(0,false);
    break;
  case DOWN:
    c.rotate(0,true);
    break;
  }
    
}
