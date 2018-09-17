package animator.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Class which has the Shapes and animations and acts as a model.
 */
public class ModelImpl<T extends ShapeAnimationImpl> implements Model<T> {
  private Map<String, Shape> shapes;
  private Map<String, List<T>> animations;

  /**
   * Constructor for the model.
   */
  public ModelImpl() {
    this.shapes = new HashMap<>();
    this.animations = new HashMap<>();
  }

  @Override
  public void addShape(Shape shape) {
    this.shapes.put(shape.getName(), shape);
    this.animations.put(shape.getName(), new ArrayList<>());
  }

  @Override
  public void removeShape(String name) {
    if (this.shapes.containsKey(name)) {
      this.shapes.remove(name);
      this.animations.remove(name);
    } else {
      throw new IllegalArgumentException("That shape does not exist.");
    }
  }

  @Override
  public void addAnimation(T animation) throws IllegalArgumentException {
    String name = animation.getName();
    if (this.animations.containsKey(name)) {
      if ((this.shapes.get(name).getHide() >= animation.getEnd())
              && (this.shapes.get(name).getShow() <= animation.getStart())
              && (this.shapes.get(name).getShow() >= 0)) {
        this.animations.get(name).add(animation);
      } else {
        throw new IllegalArgumentException("Start and end time of animation must be between the " +
                "show and hide time of the shape and start time must be positive");
      }
    } else {
      throw new IllegalArgumentException("That shape does not exist.");
    }
  }

  @Override
  public void removeAnimation(String name, int i) throws IllegalArgumentException {
    if (this.animations.containsKey(name)) {
      if (i < this.animations.get(name).size() && i >= 0) {
        this.animations.get(name).remove(i);
      } else {
        throw new IllegalArgumentException("Index is out of bounds.");
      }
    } else {
      throw new IllegalArgumentException("That shape does not exist.");
    }
  }

  @Override
  public Map<String, Shape> getAllShapes() {
    return shapes;
  }

  @Override
  public Map<String, List<T>> getAllAnimations() {
    return animations;
  }

}
