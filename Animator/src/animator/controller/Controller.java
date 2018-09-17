package animator.controller;

import java.io.IOException;

import animator.model.Model;
import animator.model.ViewModel;
import animator.model.ViewModelImpl;
import animator.view.View;

/**
 * controller for your program.
 */
public class Controller {
  private Model model;
  private View view;

  /**
   * Constructor for the controller.
   *
   * @param model the model which has all the data.
   * @param view  the view that is required.
   */
  public Controller(Model model, View view) {
    this.model = model;
    this.view = view;
  }

  /**
   * Go method for the controller.
   */
  public void goController() throws IOException {
    ViewModel vm = new ViewModelImpl(model);
    view.getView(vm);
  }
}

