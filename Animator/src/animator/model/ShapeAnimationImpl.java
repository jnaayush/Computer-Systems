package animator.model;

/**
 * An Abstract class for the shape animation.
 */
public abstract class ShapeAnimationImpl implements ShapeAnimation {
  protected String name;
  protected double start;
  protected double end;

  /**
   * Constructor for the ShapeAnimationImpl.
   *
   * @param name  the name of the shape.
   * @param start the time the animation starts
   * @param end   the end time of the animation
   * @throws IllegalArgumentException when end time is before start time.
   */
  protected ShapeAnimationImpl(String name, double start, double end)
          throws IllegalArgumentException {
    if (end < start) {
      throw new IllegalArgumentException("Animations must have an end time after they start.");
    }

    this.name = name;
    this.start = start;
    this.end = end;
  }

  @Override
  public String getName() {
    return this.name;
  }

  @Override
  public double getStart() {
    return this.start;
  }

  @Override
  public double getEnd() {
    return this.end;
  }


  /**
   * compares the start times of the animations.
   *
   * @param other the animation to be compared to this.
   * @return negative when this is less than other, 0 is they are same, positive otherwise.
   */
  public int compareTo(ShapeAnimation other) {
    return Double.compare(this.start, other.getStart());
  }


}