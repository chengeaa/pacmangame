class ghost {
  int x;
  int y; 
  int r = 30;
  float[] mycolor;
  ghost(int inx, int iny) {
    x = inx;
    y = iny;
    mycolor = new float[]{random(255), random(255),random(255)};
  }
  
  void draw() {
    noStroke();
    fill(mycolor[0],mycolor[1],mycolor[2]);
    ellipse(x,y,r,r);
  }
}