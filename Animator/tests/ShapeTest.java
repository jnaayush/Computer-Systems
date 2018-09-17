import org.junit.Before;
import org.junit.Test;

import animator.model.AnchorPoint;
import animator.model.Oval;
import animator.model.Rectangle;
import animator.model.Shape;

import static junit.framework.TestCase.fail;
import static org.junit.Assert.assertEquals;

/**
 * A JUnit java class for testing the Shape.
 */
public class ShapeTest {

  private Shape shapeSquare;
  private Shape shapeOval;

  /**
   * Creates objects of shape.
   */
  @Before
  public void setUp() {
    shapeSquare = new Rectangle("S1", AnchorPoint.BOTTOMLEFT, 0, 10, 255,
            255, 255,
            100, 100, 100, 100, 1);
    shapeOval = new Oval("O1", AnchorPoint.CENTER, 10, 20, 100, 100, 100,
            0, 0, 20, 20, 2);

  }

  /**
   * Tests for the exceptions.
   */
  @Test
  public void testExceptions() {
    try {
      shapeSquare = new Rectangle("S1", AnchorPoint.BOTTOMLEFT, 0, 10, 255,
              255, 255,
              -100, -100, -100, 100, 1);
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("Dimensions must be greater than 0.", e.getMessage());
    }
    try {
      shapeSquare = new Rectangle("S1", AnchorPoint.BOTTOMLEFT, 0, 10, 255,
              255, 255,
              100, 100, 100, 100, 2);
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }


    //Getting invalid colors
    try {
      shapeSquare.setColor(-10, 100, 355);
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("Invalid color range", e.getMessage());
    }
    try {
      shapeSquare.setColor(255, 255, 255);
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }

    //Setting invalid width
    try {
      shapeSquare.setWidth(-10);
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("Width must be greater than 0.", e.getMessage());
    }
    try {
      shapeSquare.setWidth(10);
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }

    //Setting invalid height
    try {
      shapeSquare.setHeight(-10);
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("Height must be greater than 0.", e.getMessage());
    }
    try {
      shapeSquare.setHeight(10);
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }
  }

  /**
   * Tests the getters.
   */
  @Test
  public void testGetters() {
    assertEquals("S1", shapeSquare.getName());
    assertEquals("Rectangle", shapeSquare.getType());
    assertEquals(0, shapeSquare.getShow(), 0.1);
    assertEquals(10, shapeSquare.getHide(), 0.1);
    assertEquals(255, shapeSquare.getColor().getRed(), 0.1);
    assertEquals(255, shapeSquare.getColor().getGreen(), 0.1);
    assertEquals(255, shapeSquare.getColor().getBlue(), 0.1);
    assertEquals(100, shapeSquare.getHeight(), 0.1);
    assertEquals(100, shapeSquare.getWidth(), 0.1);
    assertEquals(100, shapeSquare.getPosition().getX(), 0.1);
    assertEquals(100, shapeSquare.getPosition().getY(), 0.1);
    assertEquals("Bottom Left", shapeSquare.getAnchor().toString());
    assertEquals(1, shapeSquare.getIndex());

    assertEquals("O1", shapeOval.getName());
    assertEquals("Oval", shapeOval.getType());
    assertEquals(10, shapeOval.getShow(), 0.1);
    assertEquals(20, shapeOval.getHide(), 0.1);
    assertEquals(100, shapeOval.getColor().getRed(), 0.1);
    assertEquals(100, shapeOval.getColor().getGreen(), 0.1);
    assertEquals(100, shapeOval.getColor().getBlue(), 0.1);
    assertEquals(20, shapeOval.getHeight(), 0.1);
    assertEquals(20, shapeOval.getWidth(), 0.1);
    assertEquals(0, shapeOval.getPosition().getX(), 0.1);
    assertEquals(0, shapeOval.getPosition().getY(), 0.1);
    assertEquals("Center", shapeOval.getAnchor().toString());
    assertEquals(2, shapeOval.getIndex());
  }


  /**
   * Tests the setters for the shape.
   */
  @Test
  public void testSetters() {
    assertEquals(100, shapeSquare.getPosition().getX(), 0.1);
    assertEquals(100, shapeSquare.getPosition().getY(), 0.1);
    shapeSquare.setPosition(20, 20);
    assertEquals(20, shapeSquare.getPosition().getX(), 0.1);
    assertEquals(20, shapeSquare.getPosition().getY(), 0.1);

    assertEquals("Bottom Left", shapeSquare.getAnchor().toString());
    shapeSquare.setAnchor(AnchorPoint.CENTER);
    assertEquals("Center", shapeSquare.getAnchor().toString());


    assertEquals(255, shapeSquare.getColor().getRed(), 0.1);
    assertEquals(255, shapeSquare.getColor().getGreen(), 0.1);
    assertEquals(255, shapeSquare.getColor().getBlue(), 0.1);
    shapeSquare.setColor(100, 100, 100);
    assertEquals(100, shapeSquare.getColor().getRed(), 0.1);
    assertEquals(100, shapeSquare.getColor().getGreen(), 0.1);
    assertEquals(100, shapeSquare.getColor().getBlue(), 0.1);

    assertEquals(100, shapeSquare.getHeight(), 0.1);
    assertEquals(100, shapeSquare.getWidth(), 0.1);
    shapeSquare.setWidth(90);
    shapeSquare.setHeight(95);
    assertEquals(95, shapeSquare.getHeight(), 0.1);
    assertEquals(90, shapeSquare.getWidth(), 0.1);

  }
}