package animator.model;

/**
 * A example of an animation.
 */
public class Resize extends ShapeAnimationImpl implements ShapeAnimation {
  private double startWidth;
  private double startHeight;
  private double endWidth;
  private double endHeight;

  /**
   * Constructor for the Resize.
   *
   * @param name        the name of the shape.
   * @param start       the start time of animation
   * @param end         the end time of the animation
   * @param startWidth  the start width of the shape
   * @param startHeight the start height of the shape
   * @param endWidth    the end width of the shape
   * @param endHeight   the end heigh of the shape
   * @throws IllegalArgumentException when dimension are negative
   */
  public Resize(String name, double start, double end, double startWidth, double startHeight,
                double endWidth, double endHeight) throws IllegalArgumentException {
    super(name, start, end);

    if (startWidth <= 0 || startHeight <= 0 || endWidth <= 0 || endHeight <= 0) {
      throw new IllegalArgumentException("Dimensions must be greater than 0.");
    }

    this.startWidth = startWidth;
    this.startHeight = startHeight;
    this.endWidth = endWidth;
    this.endHeight = endHeight;
  }

  /**
   * returns the start width.
   *
   * @return the start width.
   */
  public double getStartWidth() {
    return this.startWidth;
  }

  /**
   * returns the start height.
   *
   * @return the start height.
   */
  public double getStartHeight() {
    return this.startHeight;
  }


  @Override
  public String getAttribute() {
    return "scale";
  }

  @Override
  public double[] getFrom() {
    double[] from = {startWidth, startHeight};
    return from;
  }

  @Override
  public double[] getTo() {
    double[] to = {endWidth, endHeight};
    return to;
  }
}