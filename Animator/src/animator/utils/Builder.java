package animator.utils;

import animator.model.Model;

import animator.model.Resize;

import animator.model.ShapeAnimationImpl;

import animator.model.ModelImpl;

import animator.model.AnchorPoint;

import animator.model.Oval;

import animator.model.Rectangle;

import animator.model.Translate;

import animator.model.Recolor;

public class Builder implements TweenModelBuilder<Model> {
  private Model<ShapeAnimationImpl> model = new ModelImpl<>();
  private int index = 0;

  private static int[] convertColors(float red, float green, float blue) {
    int[] colors = new int[3];
    colors[0] = Math.round(red * 255);
    colors[1] = Math.round(green * 255);
    colors[2] = Math.round(blue * 255);
    return colors;
  }

  @Override
  public TweenModelBuilder<Model> addOval(String name, float cx, float cy,
                                          float xRadius, float yRadius,
                                          float red, float green, float blue,
                                          int startOfLife, int endOfLife) {
    int[] colors = convertColors(red, green, blue);
    Oval newOval = new Oval(name, AnchorPoint.CENTER, startOfLife, endOfLife,
            colors[0], colors[1], colors[2], cx, cy, xRadius * 2, yRadius * 2,
            this.index);
    this.model.addShape(newOval);
    this.index += 1;
    return this;
  }

  @Override
  public TweenModelBuilder<Model> addRectangle(String name, float lx, float ly,
                                               float width, float height,
                                               float red, float green, float blue,
                                               int startOfLife, int endOfLife) {
    int[] colors = convertColors(red, green, blue);
    Rectangle newRectangle = new Rectangle(name, AnchorPoint.BOTTOMLEFT, startOfLife, endOfLife,
            colors[0], colors[1], colors[2], lx, ly, width, height, this.index);
    this.model.addShape(newRectangle);
    this.index += 1;
    return this;
  }

  @Override
  public TweenModelBuilder<Model> addMove(String name, float moveFromX, float moveFromY,
                                          float moveToX, float moveToY,
                                          int startTime, int endTime) {
    Translate move = new Translate(name, startTime, endTime,
            moveFromX, moveFromY, moveToX, moveToY);
    this.model.addAnimation(move);
    return this;
  }

  @Override
  public TweenModelBuilder<Model> addColorChange(String name,
                                                 float oldR, float oldG, float oldB,
                                                 float newR, float newG, float newB,
                                                 int startTime, int endTime) {
    int[] oldColors = convertColors(oldR, oldG, oldB);
    int[] newColors = convertColors(newR, newG, newB);
    Recolor recolor = new Recolor(name, startTime, endTime,
            oldColors[0], oldColors[1], oldColors[2],
            newColors[0], newColors[1], newColors[2]);
    this.model.addAnimation(recolor);
    return this;
  }

  @Override
  public TweenModelBuilder<Model> addScaleToChange(String name, float fromSx, float fromSy,
                                                   float toSx, float toSy,
                                                   int startTime, int endTime) {
    Resize scale = new Resize(name, startTime, endTime, fromSx, fromSy, toSx, toSy);
    this.model.addAnimation(scale);
    return this;
  }

  @Override
  public Model build() {
    return this.model;
  }
}
