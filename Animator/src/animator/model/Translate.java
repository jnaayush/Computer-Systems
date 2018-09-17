package animator.model;

import java.awt.geom.Point2D;

/**
 * An Example of an animation.
 */
public class Translate extends ShapeAnimationImpl implements ShapeAnimation {
  private Point2D startPoint;
  private Point2D endPoint;

  /**
   * The Constructor for the translate.
   *
   * @param name   the name of the shape it represents.
   * @param start  the start time of the translate
   * @param end    the end time of the translate
   * @param startX the start X of the translate
   * @param startY the start Y of the translate
   * @param endX   the end X of the translate
   * @param endY   the end Y of the translate
   */
  public Translate(String name, double start, double end, double startX, double startY,
                   double endX, double endY) {
    super(name, start, end);
    this.startPoint = new Point2D.Double(startX, startY);
    this.endPoint = new Point2D.Double(endX, endY);
  }

  /**
   * returns the start point.
   *
   * @return the start point.
   */
  private Point2D getStartPoint() {
    return this.startPoint;
  }

  /**
   * returns the end point.
   *
   * @return the end point.
   */
  private Point2D getEndPoint() {
    return this.endPoint;
  }

  @Override
  public String getAttribute() {
    return "translate";
  }

  @Override
  public double[] getFrom() {
    double[] from = {getStartPoint().getX(), getStartPoint().getY()};
    return from;
  }

  @Override
  public double[] getTo() {
    double[] to = {getEndPoint().getX(), getEndPoint().getY()};
    return to;
  }
}