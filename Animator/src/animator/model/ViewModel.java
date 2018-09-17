package animator.model;

import java.util.List;

/**
 * Interface containing all methods that which allows data to sent to view and restricting its
 * mutation.
 */
public interface ViewModel {

  /**
   * returns a List of shapes which are packaged with only the getters to avoid the mutation.
   *
   * @return List of shapes which are packaged with only the getters to avoid the mutation.
   */
  List<ShapeWithGetters> getAllShapes();

  /**
   * returns a List of animations which are packaged with only the getters to avoid the mutation.
   *
   * @return List of animations which are packaged with only the getters to avoid the mutation.
   */
  List<ShapeAnimationWithGetters> getAllAnimation();
}
