package animator.view;

import java.io.FileOutputStream;

import java.io.IOException;


/**
 * Implementation of the view.
 */
public abstract class ViewImpl implements View {

  double speed;
  String outputName;

  /**
   * Constructor for the ViewImpl.
   *
   * @param speed      the speed of the animation.
   * @param outputName the output name of the file
   */
  ViewImpl(double speed, String outputName) throws IllegalArgumentException {
    if (speed <= 0) {
      throw new IllegalArgumentException("Speed must be positive.");
    }
    this.speed = speed;
    this.outputName = outputName;
  }


  /**
   * Write the output to the file.
   *
   * @param str the output string after processing
   * @throws IOException the error in writing a file.
   */
  void writeToFile(String str) throws IOException {
    System.out.println("Writing to file..");
    FileOutputStream outputStream = new FileOutputStream(outputName);
    byte[] strToBytes = str.getBytes();
    outputStream.write(strToBytes);
    outputStream.close();
    System.out.println("Write complete..");
  }
}
