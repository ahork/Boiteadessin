import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus
int x,y,xx,yy;
int colorline,colorback;
boolean GD = false;
int clear = 1;
int pxd = 1;
int  diagx,diagy = 0;

void setup() {
  //init 
  size(400, 400);
  background(255);
  pxd = 1; // stroke
  colorback = 255;
  colorline = 0;
  colorMode(RGB,100);
  
  MidiBus.list();

  //set cursor center
  x = xx = width/2;
  y = yy = height/2;
    
  // use return of MidiBus.list();
  myBus = new MidiBus(this, 1, 3);

  myBus.sendNoteOn(0, 6, 0); // reset button Diag
  myBus.sendNoteOn(0, 41, 0); // reset button Diag
}

void draw() {
 
  strokeWeight(pxd);
  strokeJoin(ROUND);
  stroke(colorline,colorline/2,colorline/3);
    
  
  line (y,x, yy,xx);
  y = yy;
  x = xx;
  
  // don't touch decoration 
  if(x> width-70) { x = width-70; 
                 xx = width-70; }
  
  if(y> height-20) {y = height-20;
                  yy = height-20;}
   
  if(x< 20) { x = 20; 
                 xx = 20; }
  
  if(y< 20) {y = 20;
             yy = 20;}
  
 // init screen 
 if (clear==1) {
     background(255,255,255);     
     clear = 0;
     strokeWeight(40);
     stroke(255,0,0);
     
     // draw decoration 
     rect(0, 0, width, height, 7);
     fill(255,0,0);
     rect(0, height-50, width, height, 7);
     noFill();
     noStroke();     
     fill(255,255,255);
     circle(width-50, height - 40, 40);
     circle(50, height - 40, 40);
     noFill();
     }
  
}

// capture events 
void noteOn(int channel, int pitch, int velocity) {
  
  // activ diagonal Y 
  if ( pitch==41)
      {
          
          switch(diagy) {
            case 0: 
              diagy = 1;
              myBus.sendNoteOn(channel, 41, 127); // Send a Midi noteOn
              break;
            case 1: 
              diagy = 2;
              myBus.sendNoteOn(channel, 41, 64); // Send a Midi noteOn
              break;
            case 2: 
              diagy = 0;
              myBus.sendNoteOn(channel, 41, 0); // Send a Midi noteOn
              break;
          }
        
      }
  
  // activ diagonal X
  if ( pitch==6)
      {
          
          switch(diagx) {
            case 0: 
              diagx = 1;
              myBus.sendNoteOn(channel, 6, 127); // Send a Midi noteOn
              break;
            case 1: 
              diagx = 2;
              myBus.sendNoteOn(channel, 6, 64); // Send a Midi noteOn
              break;
            case 2: 
              diagx = 0;
              myBus.sendNoteOn(channel, 6, 0); // Send a Midi noteOn
              break;
          }
        
      }
  
  
  // Add y
  if ( pitch==84) 
    {
      
      yy = y + 1;  
      xx = x;
    }
    
    // subtract y
    if ( pitch==85) 
    {
      
      yy = y - 1;
      xx = x;
    }
  
  // add X
  if ( pitch==86) 
    {
      
      xx = x + 1;
      yy = y;
    }
    // subtract x
    if ( pitch==87) 
    {
      
      xx = x - 1;
      yy = y;
    }
    
    if (diagx == 1)
    {
        xx = x+1;
    }
     if (diagy == 1)
    {
        yy = y+1;
    }
    if (diagx == 2)
    {
        xx = x-1;
    }
     if (diagy == 2)
    {
        yy = y-1;
    }
}

// Actions
void controllerChange(int channel, int number, int value) {
    
  if ( (number== 65) && (value==0) )  { clear = 1; } //init screen 
  if ( (number== 68)  )  { pxd = value; }  // add or substract stroke 
  if ( (number== 67)  )  { colorline = value*2; } // change color 
  // add your Actions 
  // ... 
}
