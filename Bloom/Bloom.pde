PImage inputImage;
int glow = 10;
int minBrightness = 255;
float cm = 1;
float gm = 1.5;
Boolean straightBlending = true;
void setup() {
  inputImage = loadImage("C:/Users/larry/Downloads/Images/candle.jpeg");
  PImage glowObject = createImage(inputImage.width, inputImage.height, RGB);
  for(int y = 0; y < inputImage.height; y++) {
   for(int x = 0; x < inputImage.width; x++) {
    int index = y * inputImage.width + x;
    if(brightness(inputImage.pixels[index]) >= minBrightness) {
     glowObject.pixels[index] = inputImage.pixels[index];
    }
   } 
  }
  glowObject.filter(BLUR, 5);
  PImage outputImage = createImage(inputImage.width, inputImage.height, RGB);
  for(int y = 0; y < inputImage.height; y++) {
   for(int x = 0; x < inputImage.width; x++) {
    int index = y * inputImage.width + x;
    if(straightBlending) outputImage.pixels[index] = getAverageColor(glowObject, inputImage, index);
    else if(glowObject.pixels[index] == color(0,0,0)) outputImage.pixels[index] = inputImage.pixels[index];
    else outputImage.pixels[index] = getAverageColor(glowObject, inputImage, index);
   }
  }
  outputImage.save("C:/Users/larry/Desktop/glow2.png");
  exit();
}

color getAverageColor(PImage object, PImage input, int ind) {
 PVector objSq = new PVector(0,0,0);
 PVector inputSq = new PVector(0,0,0);
 objSq.x = red(object.pixels[ind])*red(object.pixels[ind])*gm;
 objSq.y = green(object.pixels[ind])*green(object.pixels[ind])*gm;
 objSq.z = blue(object.pixels[ind])*blue(object.pixels[ind])*gm;
 inputSq.x = red(input.pixels[ind])*red(input.pixels[ind]);
 inputSq.y = green(input.pixels[ind])*green(input.pixels[ind]);
 inputSq.z = blue(input.pixels[ind])*blue(input.pixels[ind]);
 color output = color(sqrt((objSq.x+inputSq.x)/2)*cm, sqrt((objSq.y+inputSq.y)/2)*cm, sqrt((objSq.z+inputSq.z)/2)*cm);
 return output;
}
