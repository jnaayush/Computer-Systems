package animator.model;

/**
 * Interface for the  Shape Animation. Contains methods which the shape animation would contain.
 */
public interface ShapeAnimation extends Comparable<ShapeAnimation> {
  /**
   * Returns the name of the animation's shape.
   *
   * @return the name of the animation's shape.
   */
  String getName();

  /**
   * Returns the start time of the animation.
   *
   * @return the start time of the animation.
   */
  double getStart();

  /**
   * Returns the end time of the animation.
   *
   * @return the end time of the animation.
   */
  double getEnd();

  /**
   * returns the attribute of the animation.
   *
   * @return the attribute of the animation.
   */
  String getAttribute();

  /**
   * returns an array containing the start point of the animation.
   *
   * @return an array containing the start point of the animation.
   */
  double[] getFrom();

  /**
   * returns an array containing the end point of the animation.
   *
   * @return an array containing the end point of the animation.
   */
  double[] getTo();
}