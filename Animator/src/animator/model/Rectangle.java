package animator.model;

/**
 * An example of the shape.
 */
public class Rectangle extends ShapeImpl implements Shape {

  /**
   * Constructor for the square.
   *
   * @param name   the name of the square
   * @param anchor the anchor point of square
   * @param show   the time square appears
   * @param hide   the time square disappears
   * @param r      the red component of the color
   * @param g      the green component of the color
   * @param b      the blue component of the color
   * @param x      the x coordinate of the position
   * @param y      the y coordinate of the position
   * @param width  the width of the square
   * @param height the height of the square
   */
  public Rectangle(String name, AnchorPoint anchor, double show, double hide, int r, int g,
                      int b, double x, double y, double width, double height, int index) {

    super(name, anchor, show, hide, r, g, b, x, y, width, height, index);
  }

  /**
   * returns the type of the shape.
   *
   * @return the type of the shape.
   */
  public String getType() {
    return "Rectangle";
  }

}
