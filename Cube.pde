class cube {
  block[][][] blocks;
  boolean turning = false;
  boolean clockwise = false;
  boolean rwhole = false;
  boolean scramble = false;
  HashMap<block,Integer> mp;
  int raxis = 0; 
  int moves = 0;
  float angle = 0;
  int tindex = 0;
  cube() {
    blocks = new block[n][n][n];
    for (int i = 0; i< n; i++) { 
      for (int j = 0; j< n; j++) { 
        for (int k = 0; k< n; k++) {
          blocks[i][j][k] = new block(new PVector(i, j, k));
        }
      }
    }
    mp = new HashMap();
  }
  void show() {
    int rev= (clockwise)?1:-1;
    for (int i = 0; i< n; i++) { 
      for (int j = 0; j< n; j++) { 
        for (int k = 0; k< n; k++) {
          pushMatrix();
          if (turning && (rwhole || mp.containsKey(blocks[i][j][k]))) {
            switch(raxis) {
            case 0:
              rotateX(rev*angle);
              break;
            case 1:
              rotateY(rev*angle);
              break;
            case 2:
              rotateZ(rev*angle);
              break;
            }
          }
          float m =(n-1)/2.0;
          translate((i-m)*wid, (j-m)*wid, (k-m)*wid);
          blocks[i][j][k].show();
          popMatrix();
        }
      }
    }
  }
  void update(){
      if (turning) {
      if (angle < PI/2) {
        int turningEaseCoeff = 2;
        if (angle<PI/8) {
          angle += speed/map(angle, 0, PI/8, turningEaseCoeff, 1);
        } else if (angle > PI/2-PI/8) {
          angle += speed/map(angle, PI/2-PI/8, PI/2, 1, turningEaseCoeff);
        } else {
          angle +=  speed;
        }
      }
      if (angle >=PI/2) {
        angle = 0;
        turning= false;
        if (rwhole) {
          finalize_rotate(raxis,clockwise);
          raxis = 0 ;
        }  
        else {
          finalize_turn(raxis,tindex,clockwise);
          raxis = 0 ;
          mp.clear();
          if(scramble){
              if(moves == 0)scramble = false;
              if(moves>0) this.scramble(moves);
          }
        }
      }
    }
  }
  //rotate the entire cube not just one section
  void rotate(int axis, boolean clockwise) {
    if (turning)return;
    turning = true;
    this.raxis = axis;
    this.rwhole = true;
    this.clockwise = clockwise;
  }
  void finalize_rotate(int axis, boolean clockwise){
    turning = false;
    rwhole = false;
    for(int i = 0 ; i< n ; i++){
      //for x and z, the perspective is fliped which requires reverse to match out perspective
      putface(i,axis,rotateface(getface(i,axis),axis==0||axis==2?!clockwise:clockwise));
    }
    for (int i = 0; i< n; i++) { 
      for (int j = 0; j< n; j++) { 
        for (int k = 0; k< n; k++) {
          if ((i!=0&&i!=n-1)&&(j!=0&&j!=n-1)&&(k!=0&&k!=n-1))continue;
          blocks[i][j][k].turn(axis,clockwise);
        }
      }
    }
  }
  void turn(int axis, int index, boolean clockwise){
    if (turning)return;
    turning = true;
    this.raxis = axis;
    this.rwhole = false;
    this.clockwise = clockwise;
    this.tindex = index;
    for(block[] lines:getface(index,axis))for(block b:lines){
      mp.put(b,0);
      b.toggle();
    }
    if(index!=0){
      for(block[] lines:getface(index-1,axis))for(block b:lines){
        b.toggle();
      }
    }
    if(index!=n-1){
      for(block[] lines:getface(index+1,axis))for(block b:lines){
        b.toggle();
      }
    }
  }
  void finalize_turn(int axis, int index, boolean clockwise){
    turning = false;
    rwhole = false;
    putface(index,axis,rotateface(getface(index,axis),axis==0||axis==2?!clockwise:clockwise));
    if(axis == 0){
      for (int i = 0; i< n; i++) { 
        for (int j = 0; j< n; j++) { 
            if ((i!=0&&i!=n-1)&&(j!=0&&j!=n-1)&&(index!=0&&index!=n-1))continue;
            blocks[index][j][i].turn(axis,clockwise);
          }
       }
     }
     else if(axis == 1){
      for (int i = 0; i< n; i++) { 
        for (int j = 0; j< n; j++) { 
            if ((i!=0&&i!=n-1)&&(j!=0&&j!=n-1)&&(index!=0&&index!=n-1))continue;
            blocks[i][index][j].turn(axis,clockwise);
          }
       }
     }
     if(axis == 2){
      for (int i = 0; i< n; i++) { 
        for (int j = 0; j< n; j++) { 
            if ((i!=0&&i!=n-1)&&(j!=0&&j!=n-1)&&(index!=0&&index!=n-1))continue;
            blocks[i][j][index].turn(axis,clockwise);
          }
       }
     }
     for(block[] lines:getface(index,axis))for(block b:lines){
      b.toggle();
    }
    if(index!=0){
      for(block[] lines:getface(index-1,axis))for(block b:lines){
        b.toggle();
      }
    }
    if(index!=n-1){
      for(block[] lines:getface(index+1,axis))for(block b:lines){
        b.toggle();
      }
    }
  }
  void putface(int i, int axis, block[][] face){
    if(axis==0){
      for(int j = 0 ; j<n ;j++){
        for(int k = 0 ; k<n ;k++){
          if ((i!=0&&i!=n-1)&&(j!=0&&j!=n-1)&&(k!=0&&k!=n-1))continue;
          blocks[i][j][k] = face[j][k];
        }
      }
    }
    //y axis
    else if (axis == 1){
      for(int j = 0 ; j<n ;j++){
        for(int k = 0 ; k<n ;k++){
          if ((i!=0&&i!=n-1)&&(j!=0&&j!=n-1)&&(k!=0&&k!=n-1))continue;
          blocks[j][i][k]= face[j][k];
        }
      }
    }
    //z axis
    else {
      for(int j = 0 ; j<n ;j++){
        for(int k = 0 ; k<n ;k++){
          if ((i!=0&&i!=n-1)&&(j!=0&&j!=n-1)&&(k!=0&&k!=n-1))continue;
          blocks[j][k][i]= face[j][k];
        }
      }
    }
  }
  block[][] getface( int i , int axis) {
    block[][]  res = new block[n][n];
    //x axs
    if(axis==0){
      for(int j = 0 ; j<n ;j++){
        for(int k = 0 ; k<n ;k++){
          res[j][k] = blocks[i][j][k];
        }
      }
    }
    //y axis
    else if (axis == 1){
      for(int j = 0 ; j<n ;j++){
        for(int k = 0 ; k<n ;k++){
          res[j][k] = blocks[j][i][k];
        }
      }
    }
    //z axis
    else {
      for(int j = 0 ; j<n ;j++){
        for(int k = 0 ; k<n ;k++){
          res[j][k] = blocks[j][k][i];
        }
      }
    }
    return res;
  }
  block[][] rotateface(block[][] face, boolean clockwise){
    if(clockwise)
    for (int i = 0; i < n / 2; i++) 
    { 
        for (int j = i; j < n-i-1; j++) 
        {   // store lt in temp variable 
            block temp = face[i][j]; 
            // move values from left to top 
            face[i][j] = face[n-1-j][i]; 
            // move values from bottom to left
            face[n-1-j][i] = face[n-1-i][n-1-j];
            // move values from right to bottom 
            face[n-1-i][n-1-j] = face[j][n-1-i]; 
            // assign temp to right 
            face[j][n-1-i] = temp; 
        } 
    }
    else 
    for (int i = 0; i < n / 2; i++) 
    { 
        for (int j = i; j < n-i-1; j++) 
        {   // store current cell in temp variable 
            block temp = face[i][j]; 
            // move values from right to top 
            face[i][j] = face[j][n-1-i]; 
            // move values from bottom to right 
            face[j][n-1-i] = face[n-1-i][n-1-j]; 
            // move values from left to bottom 
            face[n-1-i][n-1-j] = face[n-1-j][i]; 
            // assign temp to left 
            face[n-1-j][i] = temp; 
        } 
    }
    return face;
  }
  void scramble(int moves){
      scramble = true;
      this.moves=moves-1;
      this.turn((int)random(0,3),(int)random(0,n),random(1)>0.5); 
  }
}
