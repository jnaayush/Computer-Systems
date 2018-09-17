package animator.view;

import java.io.IOException;

import animator.model.ViewModel;

/**
 * A class which is the view of the program.
 */
public interface View {

  /**
   * creates the views.
   *
   * @param model the model which contains the data.
   * @throws IOException when file IO error.
   */
  void getView(ViewModel model) throws IOException;
}
