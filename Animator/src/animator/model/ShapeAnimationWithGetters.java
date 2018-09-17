package animator.model;

/**
 * A Java class which is packaging the animations with only the getters so that the view cannot
 * mutate it.
 */
public class ShapeAnimationWithGetters implements Comparable<ShapeAnimationWithGetters> {

  private ShapeAnimationImpl shapeAnimation;

  /**
   * Constructor for the ShapeAnimationImpl.
   *
   * @param shapeAnimation the shapeAnimation which is the complete shape animation from the model.
   */
  public ShapeAnimationWithGetters(ShapeAnimationImpl shapeAnimation) {

    this.shapeAnimation = shapeAnimation;
  }

  /**
   * Returns the name of the animation's shape.
   *
   * @return the name of the animation's shape.
   */
  public String getName() {
    return this.shapeAnimation.getName();
  }

  /**
   * Returns the start time of the animation.
   *
   * @return the start time of the animation.
   */
  public double getStart() {
    return this.shapeAnimation.getStart();
  }

  /**
   * Returns the end time of the animation.
   *
   * @return the end time of the animation.
   */
  public double getEnd() {
    return this.shapeAnimation.getEnd();
  }

  /**
   * returns the attribute of the animation.
   *
   * @return the attribute of the animation.
   */
  public String getAttribute() {
    return this.shapeAnimation.getAttribute();
  }

  /**
   * returns an array containing the start point of the animation.
   *
   * @return an array containing the start point of the animation.
   */
  public double[] getFrom() {
    return this.shapeAnimation.getFrom();
  }

  /**
   * returns an array containing the end point of the animation.
   *
   * @return an array containing the end point of the animation.
   */
  public double[] getTo() {
    return this.shapeAnimation.getTo();
  }

  /**
   * compares the start times of the animations.
   *
   * @param other the animation to be compared to this.
   * @return negative when this is less than other, 0 is they are same, positive otherwise.
   */
  public int compareTo(ShapeAnimationWithGetters other) {
    return Double.compare(getStart(), other.getStart());
  }

}
