class pacman {
  float x;
  float y;
  float speed = 1;
  int lr;
  int ud;
  float r = 30;
  int[] rgb = new int[]{255,255,0};
  
  pacman() {
    x = 330;
    y = 330;
    lr = 0;
    ud = 0;
  }
  
  void draw() {
    
    noStroke();
    fill(rgb[0], rgb[1], rgb[2]);
    ellipse(x,y,r,r);
  }
  void stop() {
    lr = 0;
    ud = 0;
  }
  
  void dir(int lr, int ud) {
    this.lr = lr;
    this.ud = ud;
  }
  
  void update() {
    x = x + lr * speed;
    y = y + ud * speed;
  }
}