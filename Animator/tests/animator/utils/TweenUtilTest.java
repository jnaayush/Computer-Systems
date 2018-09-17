package animator.utils;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

/**
 * A JUnit class for testing the tweening.
 */

public class TweenUtilTest {

  /**
   * Tests the tween method.
   */
  @Test
  public void testTweening() {
    double[] colorStart = {10, 10, 10};
    double[] colorEnd = {0, 0, 0};

    assertEquals(10, TweenUtil.tween(colorStart, colorEnd, 0, 0, 4)[0], 0.1);
    assertEquals(7.5, TweenUtil.tween(colorStart, colorEnd, 1, 0, 4)[0], 0.1);
    assertEquals(5, TweenUtil.tween(colorStart, colorEnd, 2, 0, 4)[0], 0.1);
    assertEquals(2.5, TweenUtil.tween(colorStart, colorEnd, 3, 0, 4)[0], 0.1);
    assertEquals(0, TweenUtil.tween(colorStart, colorEnd, 4, 0, 4)[0], 0.1);

  }


}