

size(256,144);
background(255);
PImage img;

img=loadImage("input\\i.png");

img.loadPixels();

int img_width=img.width;
int img_height=img.height;

char[][] RP=new char[img_width][img_height];
char[][] GP=new char[img_width][img_height];
char[][] BP=new char[img_width][img_height];


for(int i=0;i<img_height;i++){
  for(int j=0;j<img_width;j++){
    RP[j][i]=(char)red(img.pixels[i*img_width+j]);
    GP[j][i]=(char)green(img.pixels[i*img_width+j]);
    BP[j][i]=(char)blue(img.pixels[i*img_width+j]);
  }
}





PrintWriter writing;

writing=createWriter("img_i.h");

writing.print("const uint8_t img_i[] = {");

for(int i = 0; i < 144; i++)
{
  for(int j = 0; j < 32; j++)
  {
    byte pixByte = 0;
    
    for(int shift = 0; shift < 8; shift++)
    {
      int x = (int)((j * 8 + shift) / 256.0 * img_width);
      int y = (int)(i / 144.0 * img_height);
      
      stroke(0);
      
      if(((RP[x][y]+GP[x][y]+BP[x][y]) / 3) >= 128)
      {
        pixByte |= 1 << shift;
        stroke(255);
      }
      
      point(x, y);
      
    }
    
    writing.print("0x" + hex(pixByte));
    
    if(i != 143 || j != 31)
    {
      writing.print(", ");
    }
    
  }
}

writing.print("};\n");

writing.flush();
writing.close();
