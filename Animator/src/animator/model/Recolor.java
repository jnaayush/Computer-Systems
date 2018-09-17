package animator.model;

import java.awt.Color;

/**
 * A example of an animation.
 */
public class Recolor extends ShapeAnimationImpl implements ShapeAnimation {
  private Color startColor;
  private Color endColor;

  /**
   * Constructor for the Recolor.
   *
   * @param name  the name of the shape.
   * @param start the start time of the animation
   * @param end   the end time of the animation
   * @param sR    the start red component
   * @param sG    the start green component
   * @param sB    the start blue component
   * @param eR    the end red component
   * @param eG    the end green component
   * @param eB    the end blue component
   * @throws IllegalArgumentException when color are not in range 0 to 255
   */
  public Recolor(String name, double start, double end, int sR, int sG, int sB, int eR, int eG,
                 int eB)
          throws IllegalArgumentException {
    super(name, start, end);
    this.startColor = new Color(sR, sG, sB);
    this.endColor = new Color(eR, eG, eB);
  }

  /**
   * returns the start color of the shape.
   *
   * @return the start color of the shape
   */
  private Color getStartColor() {
    return this.startColor;
  }


  /**
   * returns the end color of the shape.
   *
   * @return the end color of the shape
   */
  private Color getEndColor() {
    return this.endColor;
  }

  @Override
  public String getAttribute() {
    return "fill";
  }

  @Override
  public double[] getFrom() {
    double[] from = {getStartColor().getRed(),getStartColor().getGreen(),getStartColor()
            .getBlue()};
    return from;
  }

  @Override
  public double[] getTo() {
    double[] to = {getEndColor().getRed(),getEndColor().getGreen(),getEndColor()
            .getBlue()};
    return to;
  }
}