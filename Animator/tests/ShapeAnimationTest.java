import org.junit.Before;
import org.junit.Test;

import animator.model.Recolor;
import animator.model.Resize;
import animator.model.Translate;

import static junit.framework.TestCase.fail;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;


/**
 * A JUnit java class to test the shape animation class.
 */
public class ShapeAnimationTest {

  private Resize animation;
  private Recolor animation1;
  private Translate animation2;


  /**
   * Creates objects of shape examples.
   */
  @Before
  public void setUp() {
    animation = new Resize("S1", 0, 10, 10, 10,
            100, 100);
    animation1 = new Recolor("S1", 0, 10, 200, 200, 200, 255, 255,
            255);
    animation2 = new Translate("S2", 1, 10, 1, 1, 10, 10);
  }

  /**
   * Tests the constructor for exceptions.
   */
  @Test
  public void testConstructor() {
    try {
      animation = new Resize("S1", 10, 0, 10, 10,
              100, 100);
      fail("SHould have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("Animations must have an end time after they start.", e.getMessage());
    }

    try {
      animation = new Resize("S1", 0, 10, 10, 10,
              100, 100);
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }
  }

  /**
   * Tests the getter method.
   */
  @Test
  public void testGetters() {
    assertEquals("S1", animation.getName());
    assertEquals(0, animation.getStart(), 0.1);
    assertEquals(10, animation.getEnd(), 0.1);

    //getters for specific animation.
    assertEquals(10, animation.getStartWidth(), 0.1);
    assertEquals(10, animation.getStartHeight(), 0.1);
  }

  /**
   * Test for getAttribute.
   */
  @Test
  public void getAttributeTest() {
    assertEquals("scale", animation.getAttribute());
    assertEquals("fill", animation1.getAttribute());
    assertEquals("translate", animation2.getAttribute());
  }

  /**
   * Test for getTo.
   */
  @Test
  public void getToTest() {
    double[] from = {100, 100};
    assertEquals(from[0], animation.getTo()[0], 0.0);
    assertEquals(from[1], animation.getTo()[1], 0.0);
    double[] from1 = {255, 255, 255};
    assertEquals(from1[0], animation1.getTo()[0], 0.0);
    assertEquals(from1[1], animation1.getTo()[1], 0.0);
    assertEquals(from1[2], animation1.getTo()[2], 0.0);
    double[] from2 = {10, 10};
    assertEquals(from2[0], animation2.getTo()[0], 0.0);
    assertEquals(from2[1], animation2.getTo()[1], 0.0);
  }

  /**
   * Test for getFrom.
   */
  @Test
  public void getFromTest() {
    double[] from = {10, 10};
    assertEquals(from[0], animation.getFrom()[0], 0.0);
    assertEquals(from[1], animation.getFrom()[1], 0.0);
    double[] from1 = {200, 200, 200};
    assertEquals(from1[0], animation1.getFrom()[0], 0.0);
    assertEquals(from1[1], animation1.getFrom()[1], 0.0);
    assertEquals(from1[2], animation1.getFrom()[2], 0.0);
    double[] from2 = {1, 1};
    assertEquals(from2[0], animation2.getFrom()[0], 0.0);
    assertEquals(from2[1], animation2.getFrom()[1], 0.0);
  }

  /**
   * Tests the compare to method.
   */
  @Test
  public void testCompareTo() {
    assertEquals(-1, animation.compareTo(animation2));
    assertEquals(1, animation2.compareTo(animation));
    assertTrue(animation2.compareTo(animation2) == 0);
  }
}