import java.io.IOException;

import animator.controller.Controller;
import animator.model.Model;
import animator.utils.AnimationFileReader;
import animator.utils.Builder;
import animator.utils.ViewFactory;
import animator.view.View;

/**
 * Part of the main class which parses the command line arguments, creates model, controller and
 * view and give control to the controller.
 */
public class StringParser {

  /**
   * Parses the command line arguments commands the controller to take over with proper inputs.
   *
   * @param args the command line arguments.
   * @throws IllegalArgumentException when invalid command is given.
   * @throws IOException              when file IO error.
   */
  public static void optionSelectorGo(String[] args) throws IllegalArgumentException, IOException {

    String inputName = "";
    boolean inputToggle = false;
    String outputName = "out";
    String typeOfView = "";
    boolean viewToggle = false;
    boolean outputToggle = false;
    double speed = 1;

    int i = 0;
    while (i < args.length) {
      if (args[i].charAt(0) == '-') {
        switch (args[i]) {
          case "-iv":
            if (i == args.length - 1 || args[i + 1].charAt(0) == '-') {
              throw new IllegalArgumentException("view type not selected");
            } else {
              if (args[i + 1].equals("text") || args[i + 1].equals("svg")
                      || args[i + 1].equals("visual")) {
                typeOfView = args[i + 1];
                viewToggle = true;
                i = i + 2;
              } else {
                throw new IllegalArgumentException("Invalid type selected");
              }

            }
            break;
          case "-if":
            if (i == args.length - 1 || args[i + 1].charAt(0) == '-') {
              throw new IllegalArgumentException("Provide the input file name after -if");
            } else {
              inputName = args[i + 1];
              inputToggle = true;
              i = i + 2;
            }
            break;
          case "-o":
            if (i == args.length - 1 || args[i + 1].charAt(0) == '-') {
              throw new IllegalArgumentException("Provide the output file name after -o");
            } else {
              outputName = args[i + 1];
              outputToggle = true;
              i = i + 2;
            }
            break;
          case "-speed":
            if (i == args.length - 1 || args[i + 1].charAt(0) == '-') {
              throw new IllegalArgumentException("Provide the tick rate after -speed");
            } else {
              speed = Double.parseDouble(args[i + 1]);
              i = i + 2;
              break;
            }
          default:
            throw new IllegalArgumentException("Not a valid input:Default");
        }

      } else {
        throw new IllegalArgumentException("Not a valid input:Start");
      }
    }
    if (outputToggle) {
      if (typeOfView.equals("text")) {
        outputName = outputName + ".txt";
      } else {
        outputName = outputName + ".svg";
      }
    }
    if (inputToggle && viewToggle) {
      System.out.println("All inputs valid, starting to process..");
      View view = ViewFactory.buildView(typeOfView, speed, outputName);
      System.out.println("Reading input file...");
      Model model = (new AnimationFileReader()).readFile(inputName, new Builder());
      System.out.println("Input file read...");
      System.out.println("Processing...");
      (new Controller(model, view)).goController();
    } else {
      throw new IllegalArgumentException("Cannot Proceed without inputFile and viewType");
    }
  }
}
