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
import animator.model.ShapeAnimationWithGetters;
import animator.model.ShapeWithGetters;
import animator.model.Translate;
import animator.model.ViewModel;
import animator.model.ViewModelImpl;

import static org.junit.Assert.assertEquals;

public class ViewModelImplTest {

  private ShapeWithGetters shapeSquareA;
  private ShapeWithGetters shapeOvalA;
  private ShapeAnimationWithGetters animation1A;
  private ShapeAnimationWithGetters animation2A;
  private ShapeAnimationWithGetters animation3A;

  /**
   * Setup for tests.
   */
  @Before
  public void setUp() {
    Model<ShapeAnimationImpl> model1;
    Shape shapeSquare;
    Shape shapeOval;
    ShapeAnimationImpl animation1;
    ShapeAnimationImpl animation2;
    ShapeAnimationImpl animation3;

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

    shapeSquareA = new ShapeWithGetters(shapeSquare);
    shapeOvalA = new ShapeWithGetters(shapeOval);
    animation1A = new ShapeAnimationWithGetters(animation1);
    animation2A = new ShapeAnimationWithGetters(animation2);
    animation3A = new ShapeAnimationWithGetters(animation3);

    ViewModel viewModel = new ViewModelImpl(model1);
  }

  /**
   * Tests the getters.
   */
  @Test
  public void testGetters() {
    assertEquals("S1", shapeSquareA.getName());
    assertEquals("Rectangle", shapeSquareA.getType());
    assertEquals(0, shapeSquareA.getShow(), 0.1);
    assertEquals(10, shapeSquareA.getHide(), 0.1);
    assertEquals(2, shapeSquareA.getColor().getRed(), 0.1);
    assertEquals(100, shapeSquareA.getColor().getGreen(), 0.1);
    assertEquals(200, shapeSquareA.getColor().getBlue(), 0.1);
    assertEquals(200, shapeSquareA.getHeight(), 0.1);
    assertEquals(200, shapeSquareA.getWidth(), 0.1);
    assertEquals(255, shapeSquareA.getPosition().getX(), 0.1);
    assertEquals(200, shapeSquareA.getPosition().getY(), 0.1);
    assertEquals("Bottom Left", shapeSquareA.getAnchor().toString());

    assertEquals("O1", shapeOvalA.getName());
    assertEquals("Oval", shapeOvalA.getType());
    assertEquals(7, shapeOvalA.getShow(), 0.1);
    assertEquals(15, shapeOvalA.getHide(), 0.1);
    assertEquals(40, shapeOvalA.getColor().getRed(), 0.1);
    assertEquals(40, shapeOvalA.getColor().getGreen(), 0.1);
    assertEquals(40, shapeOvalA.getColor().getBlue(), 0.1);
    assertEquals(200, shapeOvalA.getHeight(), 0.1);
    assertEquals(100, shapeOvalA.getWidth(), 0.1);
    assertEquals(200, shapeOvalA.getPosition().getX(), 0.1);
    assertEquals(200, shapeOvalA.getPosition().getY(), 0.1);
    assertEquals("Center", shapeOvalA.getAnchor().toString());
  }

  /**
   * Tests the getter methods.
   */
  @Test
  public void testGetter() {
    assertEquals("S1", animation1A.getName());
    assertEquals(1, animation1A.getStart(), 0.1);
    assertEquals(7, animation1A.getEnd(), 0.1);
  }

  /**
   * Test for getAttribute.
   */
  @Test
  public void getAttributeTest() {
    assertEquals("scale", animation2A.getAttribute());
    assertEquals("fill", animation3A.getAttribute());
    assertEquals("translate", animation1A.getAttribute());
  }

  /**
   * Test for getTo.
   */
  @Test
  public void getToTest() {
    double[] from = {100, 25};
    assertEquals(from[0], animation2A.getTo()[0], 0.0);
    assertEquals(from[1], animation2A.getTo()[1], 0.0);
    double[] from1 = {100, 100, 100};
    assertEquals(from1[0], animation3A.getTo()[0], 0.0);
    assertEquals(from1[1], animation3A.getTo()[1], 0.0);
    assertEquals(from1[2], animation3A.getTo()[2], 0.0);
    double[] from2 = {400, 300};
    assertEquals(from2[0], animation1A.getTo()[0], 0.0);
    assertEquals(from2[1], animation1A.getTo()[1], 0.0);
  }

  /**
   * Test for getFrom.
   */
  @Test
  public void getFromTest() {
    double[] from = {50, 50};
    assertEquals(from[0], animation2A.getFrom()[0], 0.0);
    assertEquals(from[1], animation2A.getFrom()[1], 0.0);
    double[] from1 = {255, 255, 255};
    assertEquals(from1[0], animation3A.getFrom()[0], 0.0);
    assertEquals(from1[1], animation3A.getFrom()[1], 0.0);
    assertEquals(from1[2], animation3A.getFrom()[2], 0.0);
    double[] from2 = {255, 200};
    assertEquals(from2[0], animation1A.getFrom()[0], 0.0);
    assertEquals(from2[1], animation1A.getFrom()[1], 0.0);
  }
}