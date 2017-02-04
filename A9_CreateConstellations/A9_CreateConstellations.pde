import processing.sound.*;

SoundFile C;
SoundFile D1;
SoundFile E1;
SoundFile F;
SoundFile G;
SoundFile A;
SoundFile B;
SoundFile C2;

SoundFile[] bell = {C, D1, E1, F, G, A, B, C2};

PImage moon;                                      //image of moon

float[] x = new float[50];                        //x position of the stars 
float[] y = new float[50];                        //y position of the stars
float[] size = new float[50];                     //size of the stars

int i;                                            //index stores array values inside loops
int[] xPoint = new int[50];                       //x first point of line 
int[] yPoint = new int[50];                       //y first point of line
int counter = 0;                                  //counter of lines

void setup() { 
  
//Arrays for sound files   
  bell[0] = new SoundFile(this, "xylophone-c.wav");
  bell[1] = new SoundFile(this, "xylophone-d1.wav");
  bell[2] = new SoundFile(this, "xylophone-e1.wav");
  bell[3] = new SoundFile(this, "xylophone-f.wav");
  bell[4] = new SoundFile(this, "xylophone-g.wav");
  bell[5] = new SoundFile(this, "xylophone-a.wav");
  bell[6] = new SoundFile(this, "xylophone-b.wav");
  bell[7] = new SoundFile(this, "xylophone-c2.wav");

//loads image of the moon
  moon = loadImage("moon.png");
  
//sets colormode to HSB 
  colorMode(HSB, 360, 100, 100, 100);           
  size(900, 600);                                                    

//Initial settings for x, y, and size of stars 
  for (i = 0; i < 50; i++) {
    x[i] = random(900);
    y[i] = random(600);
    size[i] = random(2, 10);
  }
}

void draw() { 
  background (224, 74, 30);               //background color to be set to dark blue
  image(moon, 50, 50, 150, 150);          //imae of the moon is set in the top right corner resized to 150px
  
//lines that draw to create constellations 
  if (counter > 1) {
    for (i = 0; i < counter - 1; i++) {
      stroke(0, 0, 100);
      line(xPoint[i], yPoint[i], xPoint[i + 1], yPoint[i + 1]);
    }
  }
  
//calling stars in draw using user defined variables
  twinklingStars();
}

//function for making the stars twinkle
void twinklingStars() {   
  for (i = 0; i < 50; i++) {
    noStroke();
    fill(0, 0, 100, random(100));
    ellipse(x[i], y[i], size[i], size[i]);
  }
}

//determines the start and end of line segment
void mousePressed() {
  xPoint[counter] = mouseX;           //indicates the start x position of line
  yPoint[counter] = mouseY;           //indicates the start y position of line
  
//boolean resets the sound of bells to play everytime line is drawn a note will play
  if (counter < 8) {
  bell[counter].play();          
  } else {
    int index = counter;
    while(index >= 8) {
      index -= 8;
    }
    bell[index].play();
  }
  counter++;
}


//pressing space resets and clears the star map
void keyPressed() {
  if (key == ' ') {
    setup();
    draw();
    counter = 0;
  }
}