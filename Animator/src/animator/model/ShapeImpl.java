package animator.model;

import java.awt.Color;
import java.awt.geom.Point2D;

/**
 * An abstract class which implement shape.
 */
public abstract class ShapeImpl implements Shape {
  protected final String name;
  protected Point2D position;
  protected AnchorPoint anchor;
  protected final double show;
  protected final double hide;
  protected Color color;
  protected double width;
  protected double height;
  protected int index;

  /**
   * Constructor for the ShapeImpl.
   *
   * @param name   the name of the shape
   * @param anchor the anchor point for the shape
   * @param show   the time when the shape appears
   * @param hide   the time when the shape disappears
   * @param r      the red component of the color
   * @param g      the green component of the color
   * @param b      the blue component of the color
   * @param x      the x coordinate of the position
   * @param y      the y coordinate of the position
   * @param width  the width of the shape
   * @param height the height of the shape
   */
  protected ShapeImpl(String name, AnchorPoint anchor, double show, double hide,
                      int r, int g, int b, double x, double y, double width, double height,
                      int index) {
    if (width <= 0 || height <= 0) {
      throw new IllegalArgumentException("Dimensions must be greater than 0.");
    }

    this.name = name;
    this.anchor = anchor;
    this.show = show;
    this.hide = hide;
    this.color = new Color(r, g, b);
    this.position = new Point2D.Double(x, y);
    this.width = width;
    this.height = height;
    this.index = index;
  }

  @Override
  public String getName() {
    return this.name;
  }

  @Override
  public Point2D getPosition() {
    return this.position;
  }

  @Override
  public AnchorPoint getAnchor() {
    return this.anchor;
  }

  @Override
  public double getShow() {
    return this.show;
  }

  @Override
  public double getHide() {
    return this.hide;
  }

  @Override
  public Color getColor() {
    return this.color;
  }

  @Override
  public double getWidth() {
    return this.width;
  }

  @Override
  public double getHeight() {
    return this.height;
  }

  @Override
  public int getIndex() {
    return this.index;
  }

  @Override
  public void setPosition(double x, double y) {
    this.position = new Point2D.Double(x, y);
  }

  @Override
  public void setAnchor(AnchorPoint anchor) {
    this.anchor = anchor;
  }

  @Override
  public void setColor(int r, int g, int b) throws IllegalArgumentException {
    if ((0 <= r) && (r <= 255) && (0 <= g) && (g <= 255) && (0 <= b) && (b <= 255)) {
      this.color = new Color(r, g, b);
    } else {
      throw new IllegalArgumentException("Invalid color range");
    }
  }

  @Override
  public void setWidth(int width) throws IllegalArgumentException {
    if (width > 0) {
      this.width = width;
    } else {
      throw new IllegalArgumentException("Width must be greater than 0.");
    }
  }

  @Override
  public void setHeight(int height) throws IllegalArgumentException {
    if (height > 0) {
      this.height = height;
    } else {
      throw new IllegalArgumentException("Height must be greater than 0.");
    }
  }
}