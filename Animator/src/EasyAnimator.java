
import java.io.IOException;

/**
 * Main class for the program EasyAnimator.
 */
public final class EasyAnimator {

  /**
   * Main function for the program.
   *
   * @param args the command line arguments.
   */
  public static void main(String[] args) {
    try {
      StringParser.optionSelectorGo(args);
    } catch (IllegalArgumentException e) {
      System.out.println(e.getMessage());
    } catch (IOException e) {
      e.printStackTrace();
    }
  }
}