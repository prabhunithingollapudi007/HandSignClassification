import SimpleOpenNI.*;

SimpleOpenNI  context;
int savedFrames = 0;

void setup()
{
  context = new SimpleOpenNI(this);
  context.setMirror(false);
  context.enableDepth();
  context.enableRGB();
  size(context.depthWidth()*2 , context.depthHeight());
  
  
}
void draw()
{
  //recording only 15 frames
  if (savedFrames == 15) exit();
  context.update();
  
  int i = savedFrames;
  int index;
  int symbol = 1;
  PVector realWorldPoint;
  PVector[] realWorldMap = context.depthMapRealWorld();
  String rbgPath = "rgb_" + symbol + "/rgb_image_" + i + ".jpg";
  String depthPath = "depth_" + symbol + "/depth_image_" + i + ".jpg";
  String filePath = "files_" + symbol + "/depth_value_" + i + ".txt";
  
  PrintWriter depthOutput = createWriter(dataPath(filePath));
  
  if (i == 0) delay(1000);
  
  //saves rgb Image 
  PImage rgbImage = context.rgbImage();
  rgbImage.save(dataPath(rbgPath));
  
  //saves depth image
  PImage dImage = context.depthImage();
  dImage.save(dataPath(depthPath));
  
  //writes depth values to file
  for(int y=0;y < context.depthHeight();y++)
  {
    for(int x=0;x < context.depthWidth() ;x++)
    {
      index = x + y * context.depthWidth();
      realWorldPoint = realWorldMap[index];
      depthOutput.println(realWorldPoint.x + " " + realWorldPoint.y + " " + realWorldPoint.z);
      
    }
  }
  
  depthOutput.flush();
  depthOutput.close();
  
  
  println("saved frame " + i);
  savedFrames++;
  image(context.depthImage(), 0, 0);   
  image(context.rgbImage(), context.depthWidth() + 10, 0);
  
}
