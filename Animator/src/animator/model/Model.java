package animator.model;

import java.util.List;
import java.util.Map;

/**
 * An interface for the model.Contains methods that the model would implement.
 */
public interface Model<T extends ShapeAnimationImpl> {
  /**
   * Adds a new shape to the shape map.
   *
   * @param shape the new shape to add ot the list.
   */
  void addShape(Shape shape);

  /**
   * Removes the shape from the shape map.
   *
   * @param name the name of the shape to remove.
   * @throws IllegalArgumentException if the shape does not exist
   */
  void removeShape(String name) throws IllegalArgumentException;

  /**
   * Adds an animation to the specified shape's animation list.
   *
   * @param animation the animation to add
   * @throws IllegalArgumentException if the shape does not exist
   */
  void addAnimation(T animation) throws IllegalArgumentException;

  /**
   * Removes an animation from a specified shape.
   *
   * @param name the name of the shape to remove the animation from.
   * @param i    the index of the animation to remove.
   * @throws IllegalArgumentException if the shape does not exist
   *                                  or the index is out of bounds
   */
  void removeAnimation(String name, int i) throws IllegalArgumentException;

  /**
   * Returns all the shapes that are present.
   * @return all the shapes in the present.
   */
  Map<String,Shape> getAllShapes();

  /**
   * returns all the animations from the data.
   * @return all the animations from the data.
   */
  Map<String, List<T>> getAllAnimations();

}
