package animator.utils;

/**
 * Class which does the tweening.
 */
public class TweenUtil {

  /**
   * Tweens the animation.
   * @param from the starting point
   * @param to the end point
   * @param tick the tick rate
   * @param start the start time
   * @param end the end time
   * @return an array containing the tweended values.
   */
  public static double[] tween(double[] from, double[] to, long tick, double start, double end) {
    double[] result = new double[from.length];
    for (int i = 0; i < from.length; i++) {
      double val = from[i] * ((end - tick) / (end - start))
              + to[i] * ((tick - start) / (end - start));
      result[i] = val;
    }
    return result;
  }
}
