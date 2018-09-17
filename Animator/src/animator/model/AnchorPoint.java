package animator.model;

/**
 * A common way to indicate what part of an image it has its position anchored to.
 */
public enum AnchorPoint {
  TOPLEFT("Top Left"), TOP("Top"), TOPRIGHT("Top Right"),
  LEFT("Left"), CENTER("Center"), RIGHT("Right"),
  BOTTOMLEFT("Bottom Left"), BOTTOM("Bottom"), BOTTOMRIGHT("Bottom Right");

  private String anchor;

  /**
   * Constructor for the Enum.
   * @param anchor the anchor point.
   */
  AnchorPoint(String anchor) {
    this.anchor = anchor;
  }

  @Override
  public String toString() {
    return this.anchor;
  }
}
