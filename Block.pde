final color green = color(0, 255, 0);
final color blue = color(0, 0, 255);
final color red = color(255, 0, 0);
final color white = color(255);
final color yellow = color(255, 255, 0);
final color orange =  color(255, 140, 0);
class block{
  color[] colors = new color[6];
  //top, bottom, left, right, front, back
  PVector pos;
  boolean showblack;
  block(PVector pos){
    this.pos = pos;
    setcolor();
    showblack=false;
  }
  void setcolor(){
    for(int i = 0; i<6;i++){
      colors[i] = color(0);
    }
    if(pos.y==0)colors[0]=white;
    if(pos.y==n-1)colors[1]=yellow;
    if(pos.x==0)colors[2]=orange;
    if(pos.x==n-1)colors[3]=red;
    if(pos.z==n-1)colors[4]=green;
    if(pos.z==0)colors[5]=blue;
  }
  void show(){
    for(int i = 0; i <colors.length;i++)drawface(i,colors[i]);
  }
  void toggle(){
    showblack = !showblack;
  }
  void drawface(int f, color c){
     if(c==(color(0))&&!showblack)return;
     fill(c);
     stroke(0);
     strokeWeight(weight);
     
     switch(f){
    case 0:
      //top
      beginShape();
      addVertex(0, 0, 1);
      addVertex(0, 0, 0);
      addVertex(1, 0, 0);
      addVertex(1, 0, 1);
      endShape(CLOSE);
      break;
    case 1:
      //bottom
      beginShape();
      addVertex(0, 1, 1);
      addVertex(0, 1, 0);
      addVertex(1, 1, 0);
      addVertex(1, 1, 1);
      endShape(CLOSE);
      break; 
    case 2:
      //left
      beginShape();
      addVertex(0, 0, 1);
      addVertex(0, 0, 0);
      addVertex(0, 1, 0);
      addVertex(0, 1, 1);
      endShape(CLOSE);
      break;
    case 3:
      //right
      beginShape();
      addVertex(1, 0, 1);
      addVertex(1, 0, 0);
      addVertex(1, 1, 0);
      addVertex(1, 1, 1);
      endShape(CLOSE);
      break;
    case 4:
      //front
      beginShape();
      addVertex(0, 0, 1);
      addVertex(1, 0, 1);
      addVertex(1, 1, 1);
      addVertex(0, 1, 1);
      endShape(CLOSE);
      break;
    case 5:
      //back
      beginShape();
      addVertex(0, 0, 0);
      addVertex(1, 0, 0);
      addVertex(1, 1, 0);
      addVertex(0, 1, 0);
      endShape(CLOSE);
      break;
    
    }
   
   }
   void turn(int axisNo, boolean clockwise) {
    //assume always clockwise
    color[] newColors = colors.clone();
    if (!clockwise) {
      turn(axisNo, true); 
      turn(axisNo, true); 
      turn(axisNo, true);
      return;
    }
    switch(axisNo) {
    case 0://x axis
      newColors[5] = colors[0];
      newColors[0] = colors[4];
      newColors[4] = colors[1];
      newColors[1] = colors[5];
      break;
    case 1://yaxis
      newColors[4] = colors[2];
      newColors[2] = colors[5];
      newColors[5] = colors[3];
      newColors[3] = colors[4];
      break;
    case 2://zaxis
      newColors[3] = colors[0];
      newColors[1] = colors[3];
      newColors[2] = colors[1];
      newColors[0] = colors[2];
      break;
    }
    colors = newColors.clone();
   }
   void addVertex(int x, int y, int z) {
    vertex((x-0.5)*wid, (y-0.5)*wid, (z-0.5)*wid);
   }
}
