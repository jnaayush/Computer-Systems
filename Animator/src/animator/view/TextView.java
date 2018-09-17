package animator.view;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import animator.model.ShapeAnimationWithGetters;
import animator.model.ShapeWithGetters;
import animator.model.ViewModel;

/**
 * The text view of the program.
 */
public class TextView extends ViewImpl implements View {

  /**
   * Constructor for the text view.
   *
   * @param speed      speed of the animation.
   * @param outputName the name of the output file.
   */
  public TextView(double speed, String outputName) {
    super(speed, outputName);
  }

  @Override
  public void getView(ViewModel vm) throws IOException {
    List<ShapeWithGetters> shapeWithGetters;
    List<ShapeAnimationWithGetters> shapeAnimationViewList;

    shapeWithGetters = vm.getAllShapes();
    shapeAnimationViewList = vm.getAllAnimation();
    String header1 = "Shapes:\n";
    String header2 = "Animations:\n";
    String body1 = "";
    String body2 = "";

    //Gets the shape information.
    for (ShapeWithGetters shape : shapeWithGetters) {
      body1 += shapeToString(shape);
    }


    //Add all animations into a list.
    Collections.sort(shapeAnimationViewList);
    for (ShapeAnimationWithGetters animation :
            shapeAnimationViewList) {
      body2 = body2 + animationToString(animation);

    }

    //selects the output type based on the outputName
    if (outputName.equals("out")) {
      System.out.println(header1 + body1 + header2 + body2);
    } else {
      writeToFile(header1 + body1 + header2 + body2);
    }

  }


  /**
   * Converts the data from the animation to the formatted string.
   *
   * @param sa the animation that is read
   * @return the formatted string which is the output of the animation.
   */
  private String animationToString(ShapeAnimationWithGetters sa) {
    switch (sa.getAttribute()) {
      case "fill":
        return "Shape " + sa.getName() + " changes color from (" +
                sa.getFrom()[0] + "," + sa.getFrom()[1] + "," + sa.getFrom()[2] + ") to ("
                + sa.getTo()[0] + "," + sa.getTo()[1] + "," + sa.getTo()[2] + ") from t="
                + sa.getStart() / speed + " " + "to t=" + sa.getEnd() / speed + "\n";
      case "translate":
        return "Shape " + sa.getName() + "  moves from (" + sa.getFrom()[0] + "," + sa.getFrom()[1]
                + ") to (" + sa.getTo()[0] + "," + sa.getTo()[1] + ") from t=" +
                sa.getStart() / speed + " to" + " t=" + sa.getEnd() / speed + "\n";
      case "scale":
        return "Shape " + sa.getName() + " scales from width: " + sa.getFrom()[0] + ", height:" +
                sa.getFrom()[1] + " to width: " + sa.getTo()[0] + ", height: " + sa.getTo()[1]
                + " from t=" + sa.getStart() / speed + "to t=" +
                sa.getEnd() / speed + "\n";
      default:
        return "Read error in shape";

    }
  }


  /**
   * Converts the data from the model(shape) to the formatted string.
   *
   * @param sh the shape that is read
   * @return the formatted string which is the output of the shape.
   */
  private String shapeToString(ShapeWithGetters sh) {
    String result = "Type: " + sh.getType() + "\n";
    String line0 = "Name: " + sh.getName() + "\n";
    String line1 = "Anchor: " + sh.getAnchor() + "\n";
    String line2 = "Position: (" + sh.getPosition().getX() + ", " + sh.getPosition().getY() +
            ")\n";
    String line3 = "Width: " + sh.getWidth() + "\n";
    String line4 = "Height: " + sh.getHeight() + "\n";
    String line5 = "Color: (" + sh.getColor().getRed() + ", " + sh.getColor().getGreen()
            + ", " + sh.getColor().getBlue() + ")\n";
    String line6 = "Appears at t=" + sh.getShow() / speed + "\n";
    String line7 = "Disappears at t=" + sh.getHide() / speed + "\n\n";
    result = result + line0 + line1 + line2 + line3 + line4 + line5 + line6 + line7;
    return result;

  }
}
