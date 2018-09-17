import org.junit.Before;
import org.junit.Test;

import animator.model.AnchorPoint;
import animator.model.Model;
import animator.model.ModelImpl;
import animator.model.Oval;
import animator.model.Recolor;
import animator.model.Rectangle;
import animator.model.Resize;
import animator.model.Shape;
import animator.model.ShapeAnimationImpl;
import animator.model.Translate;

import static junit.framework.TestCase.fail;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * A JUnit test file for the ShapeMap.
 */
public class ModelTest {

  private Model<ShapeAnimationImpl> model1;
  private Shape shapeSquare;
  private Shape shapeOval;
  private ShapeAnimationImpl animation1;
  private ShapeAnimationImpl animation2;
  private ShapeAnimationImpl animation3;


  /**
   * Creates and add elements to the objects.
   */
  @Before
  public void setUp() {

    shapeSquare = new Rectangle("S1", AnchorPoint.BOTTOMLEFT, 0, 10, 2, 100,
            200, 255, 200,
            200, 200, 1);
    shapeOval = new Oval("O1", AnchorPoint.CENTER, 7, 15, 40, 40, 40,
            200, 200, 100, 200, 2);
    animation1 = new Translate("S1", 1, 7, 255, 200, 400,
            300);
    animation2 = new Resize("O1", 7, 8, 50, 50, 100,
            25);
    animation3 = new Recolor("O1", 12, 15, 255, 255, 255, 100,
            100, 100);

    model1 = new ModelImpl<>();
    model1.addShape(shapeSquare);
    model1.addShape(shapeOval);
    model1.addAnimation(animation2);
    model1.addAnimation(animation3);
    model1.addAnimation(animation1);
  }


  /**
   * Tests the remove shape method.
   */
  @Test
  public void testRemoveShape() {
    model1.removeShape("O1");
    assertTrue(model1.getAllShapes().containsValue(shapeSquare));
    assertFalse(model1.getAllShapes().containsValue(shapeOval));
  }

  /**
   * Tests the remove animation method.
   */
  @Test
  public void testRemoveAnimation() {
    model1.removeAnimation("O1", 1);
    assertTrue(model1.getAllAnimations().get("O1").contains(animation2));
    assertFalse(model1.getAllAnimations().get("O1").contains(animation3));
  }

  /**
   * Tests the get all animations method.
   */
  @Test
  public void testGetAllAnimation() {
    assertTrue(model1.getAllAnimations().get("O1").contains(animation2));
    assertTrue(model1.getAllAnimations().get("O1").contains(animation3));
    assertFalse(model1.getAllAnimations().get("O1").contains(animation1));
  }

  /**
   * Test the get all shapes method.
   */
  @Test
  public void testGetShapes() {
    assertTrue(model1.getAllShapes().containsValue(shapeOval));
    assertTrue(model1.getAllShapes().containsValue(shapeSquare));
    model1.removeShape("O1");
    assertFalse(model1.getAllShapes().containsValue(shapeOval));
  }


  /**
   * Test for catching exceptions for adders and removers.
   */
  @Test
  public void testExceptions() {
    //Remove shape
    try {
      model1.removeShape("M1");
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("That shape does not exist.", e.getMessage());
    }

    try {
      model1.removeShape("S1");
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }


    //Add invalid animation
    try {
      model1.addAnimation(new Resize("O1", 7, 18, 50, 50,
              100, 25));
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("Start and end time of animation must be between the " +
              "show and hide time of the shape and start time must be positive", e.getMessage());
    }
    try {
      model1.addAnimation(new Resize("O1", 7, 8, 1, 2, 1,
              2));
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }


    //add animation to non existing shape
    try {
      model1.addAnimation(new Resize("Z1", 7, 18, 50, 50,
              100, 25));
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("That shape does not exist.", e.getMessage());
    }

    try {
      model1.addAnimation(new Resize("O1", 7, 8, 1, 2, 1,
              2));

    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }


    //remove shape from non existing animation
    try {
      model1.removeAnimation("S1", 0);
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("That shape does not exist.", e.getMessage());
    }

    try {
      model1.removeAnimation("O1", 0);

    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }


    //Remove non existing animation
    try {
      model1.removeAnimation("O1", 7);
      fail("Should have failed");
    } catch (IllegalArgumentException e) {
      assertEquals("Index is out of bounds.", e.getMessage());
    }

    try {
      model1.removeAnimation("O1", 0);
    } catch (IllegalArgumentException e) {
      fail("Should not have failed");
    }
  }
}