import java.util.*;

pacman me;
ghost ghost1;
ghost ghost2;
int window = 600;
int[] maze;
int[][]neighbors;
int[] dots;
int w = 60;
int rc = window/w;
int next;

void setup() {
  size(600, 600);
  next = 0;
  ghost1 = new ghost(30,30);
  ghost2 = new ghost(570,30);
  me = new pacman();
  maze = new int[(rc) * (rc)];
  neighbors = new int[rc * rc][];
  dots = new int[rc * rc];
  for (int i = 0; i < maze.length; i++) {
    //for (int y = 0; y < maze[x].length; y++) {
      int something = floor(random(5));
      maze[i] = something;
      neighbors[i] = new int[]{i + 1, i - 1, i - rc, i + rc};
      if (i % rc == 0) {
        //neighbors[i] = new int[]{i + 1, -1, i - rc, i + rc};
        if(i ==50){
          neighbors[i][1] = 59;
          continue;
        }
        neighbors[i][1] = -1;
      }
      if((i + 1) % rc == 0) {
        //neighbors[i] = new int[]{-1, i - 1, i - rc, i + rc};
        if(i==59){
          neighbors[i][0] = 50;
          continue;
        }
        neighbors[i][0] = -1;
      }
      if(i / rc == 0) {
        //neighbors[i] = new int[]{i + 1, i - 1, -1 , i + rc};
        neighbors[i][2] = -1;
      }
      if(i + rc >= rc*rc) {
        //neighbors[i] = new int[]{i + 1, i - 1, i - rc, -1};
        neighbors[i][3] = -1;
      }      
      //print("hello");
    //}
  }
  for (int[] i : neighbors) {println(i);}
  makemaze();
  connect();
  frameRate(100);
}


void draw() {
  background(0);
  maze();
  me.draw();
  //println(neighbors[floor(me.y/w) * rc + floor(me.x/w)]);
  if (me.x + me.r/2 >= window && me.lr > 0){
    if (abs(me.y - 330) < me.r/2) {
      me.x = 600 - me.x; 
    }  
  }
  else if (me.x - me.r/2 <= 0 && me.lr < 0){
    if (abs(me.y - 330) < me.r/2) {
      me.x = 600 - me.x; 
    }   
  }
  //else if (me.y - me.r/2 <= 0 && me.ud < 0){
  //  if (abs(me.y - 300) < me.r/2) {
  //    me.x = 600 - me.x; 
  //  } else {
  //    me.stop();
  //  }  
  //}
  //else if (me.y + me.r/2 >= window && me.ud > 0) {
  //  me.stop();
  //}
  
  if(hitmaze()) {
    me.stop();
  } else {
    me.update();
  }
  ghost1.draw();
  ghost2.draw();
}

boolean hitmaze() {
  int myx = floor(me.x/w);
  int myy = floor(me.y/w);
  int myindex = myy*rc + myx;
  int[] myneighbors = neighbors[myindex];
  if  (abs(me.x-(myx*w+w/2))<3 && abs(me.y-(myy*w+w/2))<3) {
    if (me.lr < 0 && myneighbors[1] < 0) {return true;}
    if (me.lr > 0 && myneighbors[0] < 0) {return true;}
    if (me.ud > 0 && myneighbors[3] < 0) {return true;}
    if (me.ud < 0 && myneighbors[2] < 0) {return true;}
  }
  return false;
}
void keyPressed() {
  if (keyCode == UP && (me.x + w * .75) % w <= me.r) {
    me.dir(0, -1);
    me.x = me.x - me.x % w + w/2;
  } else if (keyCode == DOWN && (me.x + w * .75) % w <= me.r) {
    me.dir(0, 1);
    me.x = me.x - me.x % w + w/2;  
  } else if (keyCode == RIGHT && (me.y + w * .75) % w <= me.r) {
    me.dir(1, 0);
    me.y = me.y - me.y % w + w/2;
  } else if (keyCode == LEFT && (me.y + w * .75) % w <= me.r) {
    me.dir(-1, 0);
    me.y = me.y - me.y % w + w/2;
  }
}

void maze() {
  strokeWeight(2);
  for (int i = 0; i < maze.length; i++) {
      stroke(0,50,255);
      int x = i % rc;
      int y = i / rc;
      int something = maze[i];
      int numneighbors = 4;
      for (int j: neighbors[i]) {
        if (j < 0) {numneighbors--;}
      }
      //if (something == 0) {
      //  stroke(0,0,255);
      //  if (numneighbors < 1) {stroke(100);}
      //  int uneighbor = neighbors[i][2];
      //  if (uneighbor < 0) {continue;}
      //  line(x * w, y * w, x * w + w, y * w);
      //  //neighbors[i][2] = -1;
      //  if (uneighbor > 0) {
      //    line(x * w, y * w, x * w + w, y * w);
      //    //neighbors[uneighbor][3] = -1;
      //  }
      //}
      //if (something == 1) {
      //  stroke(0,255,0);
      //  if (numneighbors < 1) {stroke(100);}
      //  int rneighbor = neighbors[i][0];
      //  if (rneighbor < 0){continue;}
      //  if (i == 50 || i == 59) {
      //    continue;
      //  }
      //  line(x * w + w, y * w, x * w + w, y * w + w);
      //  //neighbors[i][0] = -1;
      //  if (rneighbor > 0) {
      //    line(x * w + w, y * w, x * w + w, y * w + w);
      //    //neighbors[rneighbor][1] = -1;
      //  }
      //}
      //if (something == 2) {
      //  stroke(255,0,0);
      //  if (numneighbors < 1) {stroke(100);}
      //  int dneighbor = neighbors[i][3];
      //  if (dneighbor < 0) {continue;}
      //  line(x * w + w, y * w + w, x *  w, y * w + w);
      //  //neighbors[i][3] = -1;
      //  if (dneighbor > 0) {
      //    line(x * w + w, y * w + w, x *  w, y * w + w);
      //    //neighbors[dneighbor][2] = -1;
      //  }
      //}
      //if (something == 3) {
      //  stroke(0);
      //  if (numneighbors < 1) {stroke(100);}
      //  int lneighbor = neighbors[i][1];
      //  if (lneighbor < 0) {continue;}
      //  if (i == 50 || i == 59) {
      //    continue;
      //  }
      //  line(x * w, y * w + w, x * w, y * w);
      //  //neighbors[i][1] = -1;
      //  if (lneighbor > 0) {
      //    line(x * w, y * w + w, x * w, y * w);
      //    //neighbors[lneighbor][0] = -1;
      //  }
      if(neighbors[i][0] == -1){
        line(x * w + w, y * w, x * w + w, y * w + w);
      }
      if(neighbors[i][2] == -1) {
        line(x * w, y * w, x * w + w, y * w);
      }
      }
    //}
  //}
}
//
void makemaze() {
  for (int i = 0; i < maze.length; i++) {
      int something = maze[i];
      if(nn(i) <= 1) {
        maze[i] = 4; 
        continue;
      }
      if (something == 0) {
        int uneighbor = neighbors[i][2];
        if (uneighbor > 0 && nn(uneighbor) <= 1) {
          continue;
        }
        neighbors[i][2] = -1;
        if (uneighbor > 0) {
          neighbors[uneighbor][3] = -1;
        }
      }
      if (something == 1) {
        int rneighbor = neighbors[i][0];
        if (rneighbor > 0 && nn(rneighbor) <= 1) {
          continue;
        }
        if (i == 50 || i == 59) {
          continue;
        }
        neighbors[i][0] = -1;
        if (rneighbor > 0) {
          neighbors[rneighbor][1] = -1;
        }
      }
      if (something == 2) {
        int dneighbor = neighbors[i][3];
        if (dneighbor > 0 && nn(dneighbor) <= 1) {
          continue;
        }
        neighbors[i][3] = -1;
        if (dneighbor > 0) {
          neighbors[dneighbor][2] = -1;
        }
      }
      if (something == 3) {
        int lneighbor = neighbors[i][1];
        if (lneighbor > 0 && nn(lneighbor) <= 1) {
          continue;
        }
        if (i == 50 || i == 59) {
          continue;
        }
        neighbors[i][1] = -1;
        if (lneighbor > 0) {
          neighbors[lneighbor][0] = -1;
        }
      }
    //}
  }
}

int nn(int index) {
  int nn = 0;
  for(int i: neighbors[index]) {
    if (i > 0) {nn++;}
  }
  return nn;
}

void connect() {
  for (int i = 0; i < neighbors.length; i++) {
    if (connected(neighbors)) {break;}
    if (i < rc) {
      neighbors[i][3] = i + rc;
      neighbors[i + rc][2] = i;
    } else {
      neighbors[i][2] = i - rc;
      neighbors[i - rc][3] = i;
    }
  }
}

boolean connected(int[][] maze) {
  if (dfs(maze) < rc * rc) {return false;}
  return true;
}

int dfs(int[][] maze) {
  List<Integer> visited = new ArrayList<Integer>();
  Stack<Integer> fringe = new Stack<Integer>();
  fringe.push(0);
  while (!fringe.isEmpty()) {
    int next = fringe.pop();
    for (int i: maze[next]) {
      if (i > 0 && !visited.contains(i)) {fringe.push(i);}
    }
    visited.add(next);
  }
  return visited.size();
}