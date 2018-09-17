package animator.model;

/**
 * An example of a shape.
 */
public class Oval extends ShapeImpl implements Shape {

  /**
   * Constructor for the Oval.
   * @param name the name of the shape
   * @param anchor the anchor point for the oval
   * @param show the time shape appears
   * @param hide the time shape disappears
   * @param r the red component of the color
   * @param g the green component of the color
   * @param b the blue component of the color
   * @param x the x coordinate of the position
   * @param y the y coordinate of the position
   * @param width the major axis of the oval
   * @param height the minor axis of the oval
   */
  public Oval(String name, AnchorPoint anchor, double show, double hide, int r,
                 int g, int b, double x, double y, double width, double height, int index) {
    super(name, anchor, show, hide, r, g, b, x, y, width, height, index);
  }

  @Override
  public String getType() {
    return "Oval";
  }

}
