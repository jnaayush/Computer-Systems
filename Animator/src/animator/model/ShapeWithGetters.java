package animator.model;

import java.awt.Color;
import java.awt.geom.Point2D;

/**
 * A Java class which is packaging the shapes with only the getters so that the view cannot
 * mutate it.
 */
public class ShapeWithGetters implements Comparable<ShapeWithGetters> {

  private Shape shape;

  /**
   * Constructor for the ShapeWithGetters.
   *
   * @param shape the shape which is the complete shape animation from the model.
   */
  public ShapeWithGetters(Shape shape) {
    this.shape = shape;
  }


  /**
   * Returns the name given to the shape.
   *
   * @return the name given to the shape.
   */
  public String getName() {
    return this.shape.getName();
  }

  /**
   * Returns the position of the anchor of the shape.
   *
   * @return the position of the anchor of the shape.
   */
  public Point2D getPosition() {
    return this.shape.getPosition();
  }

  /**
   * Returns the anchor of the shape.
   *
   * @return the anchor of the shape.
   */
  public AnchorPoint getAnchor() {
    return this.shape.getAnchor();
  }

  /**
   * Returns the time when the shape is visible.
   *
   * @return the time when the shape is visible.
   */
  public double getShow() {
    return this.shape.getShow();
  }

  /**
   * Returns the time when the shape is no longer visible.
   *
   * @return the time when the shape is no longer visible.
   */
  public double getHide() {
    return this.shape.getHide();
  }

  /**
   * Returns the color of the shape as an RGB color array.
   *
   * @return the color of the shape as an RGB color array.
   */
  public Color getColor() {
    return this.shape.getColor();
  }

  /**
   * Returns the width of the shape.
   * Note: this can be used for polygon and round shapes.
   *
   * @return the width of the shape.
   */
  public double getWidth() {
    return this.shape.getWidth();
  }

  /**
   * Returns the height of the shape.
   * Note: this can be used for polygon and round shapes.
   *
   * @return the height of the shape.
   */
  public double getHeight() {
    return this.shape.getHeight();
  }

  /**
   * Returns the type of a shape as a string.
   *
   * @return the type of the shape
   */
  public String getType() {
    return this.shape.getType();
  }

  /**
   * Returns the index of the shape.
   * @return the index of the shape.
   */
  public int getIndex() {
    return this.shape.getIndex();
  }

  /**
   * returns the shape for the use of comparison.
   * @return the shape for the use of comparison.
   */
  private Shape getShape() {
    return this.shape;
  }

  /**
   * compares the index of the shapes.
   *
   * @param other the shape to be compared to this.
   * @return negative when index of this is less than other, 0 is they are same, positive otherwise.
   */
  @Override
  public int compareTo(ShapeWithGetters other) {
    return (this.shape.getIndex() - other.getShape().getIndex());
  }
}

