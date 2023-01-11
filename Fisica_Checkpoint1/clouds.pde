class Cloud {
  
  float x, y;
  
  Cloud(float _x) {
    x = _x;
    y = 200;
  }
  
  void show() {
    x = x + 5;
    if (x > width + 100) x = -100;
    
    fill(255);
    ellipse(x, y, 200, 100);
  }
}
