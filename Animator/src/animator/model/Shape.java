package animator.model;

import java.awt.Color;
import java.awt.geom.Point2D;


/**
 * A part of the model that will be used by every shape.
 */
public interface Shape {
  /**
   * Returns the name given to the shape.
   *
   * @return the name given to the shape.
   */
  String getName();

  /**
   * Returns the position of the anchor of the shape.
   *
   * @return the position of the anchor of the shape.
   */
  Point2D getPosition();

  /**
   * Returns the anchor of the shape.
   *
   * @return the anchor of the shape.
   */
  AnchorPoint getAnchor();

  /**
   * Returns the time when the shape is visible.
   *
   * @return the time when the shape is visible.
   */
  double getShow();

  /**
   * Returns the time when the shape is no longer visible.
   *
   * @return the time when the shape is no longer visible.
   */
  double getHide();

  /**
   * Returns the color of the shape as an RGB color array.
   *
   * @return the color of the shape as an RGB color array.
   */
  Color getColor();

  /**
   * Returns the width of the shape.
   * Note: this can be used for polygon and round shapes.
   *
   * @return the width of the shape.
   */
  double getWidth();

  /**
   * Returns the height of the shape.
   * Note: this can be used for polygon and round shapes.
   *
   * @return the height of the shape.
   */
  double getHeight();

  /**
   * Returns the type of a shape as a string.
   *
   * @return the type of the shape
   */
  String getType();

  /**
   * returns the index for the shape i.e. the order it was read.
   * @return the index for the shape i.e. the order it was read.
   */
  int getIndex();

  /**
   * Sets the position of the anchor of the shape.
   *
   * @param x the new x-coordinate
   * @param y the new y-coordinate
   */
  void setPosition(double x, double y);

  /**
   * Sets the anchor of the shape.
   *
   * @param anchor the new anchor of the shape.
   */
  void setAnchor(AnchorPoint anchor);

  /**
   * Sets the color of the shape.
   *
   * @param r the red component
   * @param g the green component
   * @param b the blue component
   */
  void setColor(int r, int g, int b);

  /**
   * Sets the width of the shape.
   *
   * @param width the new width of the shape.
   *
   * @throws IllegalArgumentException when invalid width is set.
   */
  void setWidth(int width) throws IllegalArgumentException;

  /**
   * Sets the height of the shape.
   *
   * @param height the new height of the shape.
   *
   * @throws IllegalArgumentException when invalid width is set.
   */
  void setHeight(int height) throws IllegalArgumentException;
}