package animator.utils;

import animator.view.GUIView;
import animator.view.SvgView;
import animator.view.TextView;
import animator.view.View;

/**
 * Factory class for the view. Returns a view based on the type of the view required.
 */
public class ViewFactory {

  /**
   * returns the view object based on the type of the view required.
   *
   * @param typeOfView the type of view required
   * @param speed      the speed on the animation.
   * @param outputName the output name of the file.
   * @return the view object based on the type of the view required.
   */
  public static View buildView(String typeOfView, double speed, String outputName) {
    switch (typeOfView) {
      case "text":
        return new TextView(speed, outputName);
      case "svg":
        return new SvgView(speed, outputName);
      case "visual":
        return new GUIView(speed, outputName);
      default:
        return new TextView(speed, outputName);
    }
  }
}
