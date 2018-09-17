package animator.view;

import java.io.IOException;
import java.util.List;

import animator.model.ShapeAnimationWithGetters;
import animator.model.ShapeWithGetters;
import animator.model.ViewModel;

/**
 * THe svg view for the program.
 */
public class SvgView extends ViewImpl implements View {

  private String xTag;
  private String yTag;
  private String widthTag;
  private String heightTag;

  /**
   * Constructor for the SvgView.
   *
   * @param speed      speed of the animation.
   * @param outputName the output name of the file
   */
  public SvgView(double speed, String outputName) {
    super(speed, outputName);
  }

  @Override
  public void getView(ViewModel vm) throws IOException {
    List<ShapeWithGetters> shapeWithGetters;
    List<ShapeAnimationWithGetters> shapeAnimationViewList;

    shapeWithGetters = vm.getAllShapes();
    shapeAnimationViewList = vm.getAllAnimation();
    String header1 = "<svg width=\"900\" height=\"700\" version=\"1.1\"\n" +
            "     xmlns=\"http://www.w3.org/2000/svg\">\n";
    String body1 = "";

    //Gets the shape information.
    for (ShapeWithGetters shape : shapeWithGetters) {
      body1 += shapeToSvg(shape);
      setAttributeTag(shape);
      for (ShapeAnimationWithGetters temp : shapeAnimationViewList) {
        if (shape.getName().equals(temp.getName())) {
          body1 = body1 + animationToSvg(temp);
        }
      }
      body1 = body1 + endTag(shape);
    }
    String result = header1 + body1 + "\n</svg>";

    if (outputName.equals("out")) {
      System.out.println(result);
    } else {
      writeToFile(result);
    }
  }


  /**
   * Converts the data from the animation to the formatted string.
   *
   * @param sa the animation that is read
   * @return the formatted string which is the output of the animation.
   */
  private String animationToSvg(ShapeAnimationWithGetters sa) {
    switch (sa.getAttribute()) {
      case "fill":
        String str = "";
        str = str + "<animate attributeType=\"xml\" begin=\"" + (sa.getStart() * 1000 / speed)
                + "ms\" " + "dur=\"" + (sa.getEnd() - sa.getStart()) * 1000 / speed +
                "ms\" attributeName=\"fill\" " + "from=\"rgb(" + (int) sa.getFrom()[0] + "," +
                (int) sa.getFrom()[1] + "," + (int) sa.getFrom()[2] + ")\" " + " to=\"rgb(" +
                (int) sa.getTo()[0] + "," + (int) sa.getTo()[1] + "," + (int) sa.getTo()
                [2] + ")\" " + "fill=\"freeze\" " + "/>";
        return str;
      case "translate":
        String translate = "";
        if (sa.getFrom()[0] != sa.getTo()[0]) {
          translate = "<animate attributeType=\"xml\" begin=\"" + (sa.getStart() * 1000 / speed) +
                  "ms\" " + "dur=\"" + (sa.getEnd() - sa.getStart()) * 1000 / speed + "ms\" " +
                  "attributeName=\"" + xTag + "\" " + "from=\"" + sa.getFrom()[0] + "\" to=\"" +
                  sa.getTo()[0] + "\" fill=\"freeze\" " + "/>\n";

        }
        if (sa.getFrom()[1] != sa.getTo()[1]) {
          translate = translate + "<animate attributeType=\"xml\" begin=\"" +
                  (sa.getStart() * 1000 / speed) + "ms\" " + "dur=\"" +
                  (sa.getEnd() - sa.getStart()) * 1000 / speed + "ms\" attributeName=\"" + yTag +
                  "\"" + " " + "from=\"" + sa.getFrom()[1] + "\" to=\"" + sa.getTo()[1] + "\" " +
                  "fill=\"freeze\"/>\n";
        }
        return translate;
      case "scale":
        String scale = "";
        if (sa.getFrom()[0] != sa.getTo()[0]) {
          scale = "<animate attributeType=\"xml\" begin=\"" + (sa.getStart() * 1000 / speed) +
                  "ms\" " + "dur=\"" + (sa.getEnd() - sa.getStart()) * 1000 / speed +
                  "ms\" attributeName=\"" + widthTag + "\"" + " " + "from=\"" + sa.getFrom()[0] +
                  "\" to=\"" + sa.getTo()[0] + "\" fill=\"freeze\"/>\n";

        }
        if (sa.getFrom()[1] != sa.getTo()[1]) {
          scale = scale + "<animate attributeType=\"xml\" begin=\"" + (sa.getStart() * 1000 / speed)
                  + "ms\" " +
                  "dur=\"" + (sa.getEnd() - sa.getStart()) * 1000 / speed + "ms\" " +
                  "attributeName=\"" + heightTag + "\" " +
                  "from=\"" + sa.getFrom()[1] + "\" to=\"" + sa.getTo()[1] +
                  "\" fill=\"freeze\"/>\n";
        }
        return scale;
      default:
        return "Read error in shape";
    }
  }


  /**
   * Converts the data from the shape to the formatted string.
   *
   * @param sh the shape that is read
   * @return the formatted string which is the output of the shape.
   */
  private String shapeToSvg(ShapeWithGetters sh) {
    String str = "";
    switch (sh.getType()) {
      case "Rectangle":
        str = "\n<rect";
        break;
      case "Oval":
        str = "\n<ellipse";
        str = str + " id=\"" + sh.getName() + "\" cx=\"" + sh.getPosition().getX() + "\"";
        str = str + " cy=\"" + sh.getPosition().getY() + "\" rx=\"" + (sh.getWidth() / 2) +
                "\" ry=\"" + (sh.getHeight() / 2) + "\"";
        str = str + " fill=\"rgb(" + sh.getColor().getRed() + "," + sh.getColor().getGreen() + ",";
        str = str + sh.getColor().getBlue() + ")\" visibility=\"hidden\">\n";
        str = str + "<animate attributeName=\"visibility\" attributeType=\"xml\" to=\"visible\"\n" +
                "           begin=\"" + sh.getShow() * 1000 / speed + "ms\" dur=\""
                + (sh.getHide() - sh.getShow()) * 1000 / speed + "ms\" fill=\"freeze\" />";
        str = str + "<animate attributeName=\"visibility\" attributeType=\"xml\" to=\"hidden\"\n" +
                "           begin=\"" + sh.getHide() * 1000 / speed + "ms\" fill=\"freeze\" />";
        return str;
      default:
        break;
    }

    str = str + " id=\"" + sh.getName() + "\" x=\"" + sh.getPosition().getX() + "\"";
    str = str + " y=\"" + sh.getPosition().getY() + "\" width=\"" + sh.getWidth() +
            "\" height=\"" + sh.getHeight() + "\"";
    str = str + " fill=\"rgb(" + sh.getColor().getRed() + "," + sh.getColor().getGreen() + ",";
    str = str + sh.getColor().getBlue() + ")\" visibility=\"hidden\">\n";
    str = str + "<animate attributeName=\"visibility\" attributeType=\"xml\" to=\"visible\"\n" +
            "           begin=\"" + sh.getShow() * 1000 / speed + "ms\" dur=\"" +
            (sh.getHide() - sh.getShow()) * 1000 / speed + "ms\" fill=\"freeze\" />";
    str = str + "<animate attributeName=\"visibility\" attributeType=\"xml\" to=\"hidden\"\n" +
            "           begin=\"" + sh.getHide() * 1000 / speed + "ms\" fill=\"freeze\" />";
    return str;

  }

  /**
   * pulls the end tag to complete a shape.
   *
   * @param sh the shape for which end tag is needed
   * @return the end tag for the shape
   */
  private String endTag(ShapeWithGetters sh) {
    switch (sh.getType()) {
      case "Rectangle":
        return "\n</rect>";
      case "Oval":
        return "\n</ellipse>";
      default:
        return "/>";
    }
  }

  /**
   * Sets the attribute tag for the animation for each shape. This allows future extension to
   * support different shapes.
   *
   * @param sh shape for which tags are required.
   */
  private void setAttributeTag(ShapeWithGetters sh) {
    switch (sh.getType()) {
      case "Rectangle":
        xTag = "x";
        yTag = "y";
        widthTag = "width";
        heightTag = "height";
        break;
      case "Oval":
        xTag = "cx";
        yTag = "cy";
        widthTag = "rx";
        heightTag = "ry";
        break;
      default:
        System.out.println("Invalid Shape");
        break;
    }
  }

}
