package animator.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * Implementation of the ViewModel. It packages the data for the view by only allowing access to
 * the getters.
 */
public class ViewModelImpl implements ViewModel {

  private Model model;

  /**
   * Constructor for the ViewModelImpl.
   *
   * @param model the model with is the complete model.
   */
  public ViewModelImpl(Model model) {
    this.model = model;
  }

  @Override
  public List<ShapeWithGetters> getAllShapes() {

    Map<String, Shape> data = model.getAllShapes();
    List<ShapeWithGetters> shapeViewList = new ArrayList<>();

    for (Map.Entry<String, Shape> each : data.entrySet()) {
      ShapeWithGetters shapeView = new ShapeWithGetters(each.getValue());
      shapeViewList.add(shapeView);
    }
    Collections.sort(shapeViewList);
    return shapeViewList;
  }

  @Override
  public List<ShapeAnimationWithGetters> getAllAnimation() {

    Map<String, List<ShapeAnimationImpl>> data = model.getAllAnimations();
    List<ShapeAnimationWithGetters> shapeAnimationViewList = new ArrayList<>();

    for (Map.Entry<String, List<ShapeAnimationImpl>> each : data.entrySet()) {
      for (ShapeAnimationImpl temp : each.getValue()) {
        ShapeAnimationWithGetters shapeAnimationView = new ShapeAnimationWithGetters(temp);
        shapeAnimationViewList.add(shapeAnimationView);

      }
    }
    return shapeAnimationViewList;
  }
}
