import org.junit.Before;
import org.junit.Test;

import animator.view.SvgView;
import animator.view.View;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;


/**
 * JUnit class to test the View classes.
 */
public class ViewTest {

  /**
   * Setup for Tests.
   */
  @Before
  public void setup() {
    View testView = new SvgView(10, "test");
  }

  /**
   * Test for illegal view construction.
   */
  @Test
  public void testIllegal() {
    try {
      new SvgView(-1, "test");
      fail("Should have thrown an exception");
    } catch (IllegalArgumentException e) {
      assertEquals("Speed must be positive.", e.getMessage());
    }

    try {
      new SvgView(0, "test");
      fail("Should have thrown an exception");
    } catch (IllegalArgumentException e) {
      assertEquals("Speed must be positive.", e.getMessage());
    }
  }
}