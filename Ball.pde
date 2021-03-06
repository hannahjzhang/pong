// In this tab, you must write code in:
//
// * intersectsPaddle(Paddle paddle)
// * move()

class Ball {
  private float radius;
  private float x;
  private float y;
  private PVector vector;
  private color fillColor;
  
  public Ball(float x, float y, float radius, PVector vector, color c) {
    this.x = x;
    this.y = y;
    this.vector = vector;
    this.radius = radius;
    this.fillColor = c;
  }
  
  public float getX() { return x; }
  public float getY() { return y; }
  public void setX(int x) { this.x = x; }
  public void setY(int y) { this.y = y; }
  public float getRadius() { return radius; }
  public PVector getVector() { return vector; }
  public void setVector(PVector vector) { this.vector = vector; }
  
  public float distance(Ball other) {
    return (float) Math.sqrt(square(getX()-other.getX()) + square(getY()-other.getY()));
  }
  
  // Returns true if ball is touching a vertical wall
  public boolean intersectsVertical() {
    return (getX()+(width/2)+getRadius() >= width) ||
           (getX()+(width/2)-getRadius() <= 0);
  }
  
  // Returns true if ball is touching a horizontal wall
  public boolean intersectsHorizontal() {
    return (getY()+(height/2)+getRadius() >= height) ||
           (getY()+(height/2)-getRadius() <= 0);
  }
  
 // checks if the ball intersects with horizontal axis of the paddle
  public boolean intersectsHorizontalPaddle(Paddle paddle) {
    // center is 0, 0
    // if the paddle is on the left side, checks to see if the left side of the ball
    // intersects the right side of the paddle
    if (paddle.getX() < 0 && (x - radius <= (paddle.getX() + paddle.getWidth() / 2)))
    {
      return true; 
    }
    // if paddle is right, check is right ball intersects left paddle
    else if (paddle.getX() > 0 && (x + radius >= (paddle.getX() - paddle.getWidth() / 2)))
    {
      return true;
    }
    else
      return false;
  }
  
// checks if the ball intersects with the vertical axis of the paddle
  public boolean intersectsVerticalPaddle(Paddle paddle)
  {
    if (between(y, paddle.getY() - (paddle.getHeight() / 2),
        paddle.getY() + (paddle.getHeight() / 2)))
      return true;
    else
      return false;
  }

  // Return true if the ball is touching the specified paddle
  public boolean intersectsPaddle(Paddle paddle)
  {
    if (intersectsHorizontalPaddle(paddle) && intersectsVerticalPaddle(paddle))
      return true;
    else
      return false;
  }

  public void move() {
    // If the ball is not in play, it should not move
    // It is somewhat useful visually to have it stay by the wall it hits
    // when a point ends
    if (state != GAME_STATE.IN_PLAY) return;

    // If the ball is in play, then it needs to change direction if it hits
    // a paddle...
    else if (intersectsPaddle(computer) || intersectsPaddle(player))
    {
      vector.x = -1 * vector.x;
    }
    
    // ...or if it hits the top or bottom wall
    else if (intersectsHorizontal())
    {
      vector.y = -1 * vector.y;
    }
    
    // Update the coordinates of the ball
    x = getX() + vector.x;
    y = getY() + vector.y;
  }
    
  public void draw() {
    fill(fillColor);
    stroke(#000000);
    ellipse(x + width/2, y + height/2, radius, radius);
  }
}
