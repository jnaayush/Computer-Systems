package animator.view;

import java.awt.Toolkit;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.io.IOException;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;

import javax.swing.JScrollPane;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.JFormattedTextField;
import javax.swing.JTextField;
import javax.swing.BoxLayout;
import javax.swing.Timer;
import javax.swing.JLabel;
import javax.swing.text.NumberFormatter;

import animator.model.Oval;
import animator.model.Rectangle;
import animator.model.Shape;
import animator.model.ShapeAnimationWithGetters;
import animator.model.ShapeWithGetters;
import animator.model.ViewModel;
import animator.utils.TweenUtil;
import animator.utils.ViewFactory;


/**
 * The gui view class for the program.
 */
public class GUIView extends ViewImpl implements View {


  /**
   * Constructor for the SvgView.
   *
   * @param speed      speed of the animation.
   * @param outputName the output name of the file
   */
  public GUIView(double speed, String outputName) throws IllegalArgumentException {
    super(speed, outputName);
  }

  /**
   * Changes the speed of the animation based on the user input.
   */
  private void changeSpeed(double speed) {
    this.speed = speed;
  }

  /**
   * Inner class to GUI view which makes and populates the window.
   */
  private class GUIFrame extends JFrame {
    private JPanel mainPanel;
    private JScrollPane mainScrollPane;
    private AnimationFrame animationFrame;
    private JPanel optionsPanel;
    private JButton playPause;
    private JButton restart;
    private JButton changeSpeed;
    private JButton saveToSvg;
    private JButton exit;
    private JFormattedTextField speedText;
    private JTextField outputText;
    private JLabel speedTextOut;

    /**
     * Constructor for the GUIFrame.
     *
     * @param model the model which is to be animated
     */
    GUIFrame(ViewModel model) {
      super();
      setTitle("Easy Animator");
      this.setLayout(new BoxLayout(getContentPane(), BoxLayout.Y_AXIS));

      mainPanel = new JPanel();
      //for elements to be arranged vertically within this panel
      mainPanel.setLayout(new BoxLayout(mainPanel, BoxLayout.PAGE_AXIS));
      //scroll bars around this main panel
      mainScrollPane = new JScrollPane(mainPanel);
      add(mainScrollPane);
      animationFrame = new AnimationFrame(model);
      int maxW = 0;
      int maxH = 0;
      for (ShapeWithGetters shape : model.getAllShapes()) {
        double w = shape.getPosition().getX();
        double h = shape.getPosition().getY();
        if (shape.getType().equals("Rectangle")) {
          w += shape.getWidth();
          h += shape.getHeight();
        } else {
          w += shape.getWidth() / 2;
          h += shape.getHeight() / 2;
        }
        if (w > maxW) {
          maxW = (int) Math.round(w);
        }
        if (h > maxH) {
          maxH = (int) Math.round(h);
        }
      }
      int maxFW = maxW;
      int maxFH = maxH;
      Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
      if (maxFH > screenSize.getHeight() - 100) {
        maxFH = (int) Math.round(screenSize.getHeight() - 100);
      }
      if (maxFW > screenSize.getWidth()) {
        maxFW = (int) Math.round(screenSize.getWidth());
      }
      setPreferredSize(new Dimension(maxFW, maxFH));
      setMinimumSize(new Dimension(400, 0));
      animationFrame.setPreferredSize(new Dimension(maxW, maxH));
      mainPanel.add(animationFrame);
      this.setDefaultCloseOperation(EXIT_ON_CLOSE);

      optionsPanel = new JPanel();
      optionsPanel.setLayout(new BoxLayout(optionsPanel, BoxLayout.X_AXIS));
      optionsPanel.setMaximumSize(new Dimension(maxFW, (new JButton()).getPreferredSize().height));
      add(optionsPanel);

      playPause = new JButton("Pause");
      playPause.setActionCommand("Pause/Play");
      playPause.addActionListener(animationFrame);
      optionsPanel.add(playPause);

      restart = new JButton("Restart");
      restart.setActionCommand("Restart");
      restart.addActionListener(animationFrame);
      optionsPanel.add(restart);

      NumberFormat format = NumberFormat.getInstance();
      NumberFormatter formatter = new NumberFormatter(format);
      formatter.setValueClass(Integer.class);
      formatter.setMinimum(0);
      formatter.setMaximum(Integer.MAX_VALUE);
      formatter.setAllowsInvalid(true);
      speedText = new JFormattedTextField(formatter);
      optionsPanel.add(speedText);

      speedTextOut = new JLabel("" + speed);
      optionsPanel.add(speedTextOut);

      changeSpeed = new JButton("Change Speed");
      changeSpeed.setActionCommand("Change Speed");
      changeSpeed.addActionListener(animationFrame);
      optionsPanel.add(changeSpeed);

      outputText = new JTextField("OutputFileName");
      optionsPanel.add(outputText);

      outputText.addFocusListener(new FocusListener() {
        /**
         * sets empty text when the text field is in focus.
         * @param e the focus event
         */
        public void focusGained(FocusEvent e) {
          outputText.setText("");
        }

        /**
         * leave default value when the focus is lost.
         * @param e the focus event.
         */
        public void focusLost(FocusEvent e) {
          //Do Nothing.
        }
      });

      saveToSvg = new JButton("Save To Svg");
      saveToSvg.setActionCommand("Save To Svg");
      saveToSvg.addActionListener(animationFrame);
      optionsPanel.add(saveToSvg);

      exit = new JButton("exit");
      exit.setActionCommand("exit");
      exit.addActionListener(animationFrame);
      optionsPanel.add(exit);

      pack();
      setVisible(true);
    }

    /**
     * Changes the text of the play/pause button.
     */
    void changePlayPauseDisplay() {
      if (playPause.getText().equals("Play")) {
        playPause.setText("Pause");
      } else {
        playPause.setText("Play");
      }
    }

    /**
     * Reads the speed from the text box.
     *
     * @return the speed from the text box
     */
    double getSpeed() {
      double val = speed;
      if (speedText.getValue() != null) {
        val = (Integer) speedText.getValue();
      }
      return val;
    }

    /**
     * Resets the speed.
     */
    void resetSpeed() {
      speedText.setValue(null);
    }

    /**
     * Inner class to the GUI view which does the dynamic changes.
     */
    private class AnimationFrame extends JPanel implements ActionListener {
      private ViewModel model;
      private Timer timer;
      private long tick;
      private List<ShapeWithGetters> currentShapes;

      /**
       * Constructor to the animationFrame.
       *
       * @param model the model which is to be animated
       */
      AnimationFrame(ViewModel model) {
        super();
        this.model = model;
        int rate = (int) Math.round(1000 / speed);
        this.timer = new Timer(rate, this);
        this.timer.setActionCommand("Update");
        this.timer.start();
        this.tick = 0;
        resetShapes();
      }

      @Override
      public void actionPerformed(ActionEvent e) {
        switch (e.getActionCommand()) {
          case "Update":
            updateShapes();
            this.revalidate();
            this.repaint();
            tick++;
            break;
          case "Pause/Play":
            if (timer.isRunning()) {
              timer.stop();
            } else {
              timer.start();
            }
            changePlayPauseDisplay();
            break;
          case "Restart":
            resetShapes();
            tick = 0;
            revalidate();
            repaint();
            break;
          case "Change Speed":
            changeSpeed(getSpeed());
            speedTextOut.setText("" + speed);
            timer.setDelay((int) Math.round(1000 / speed));
            resetSpeed();
            break;
          case "Save To Svg":
            outputName = outputText.getText();
            View view = ViewFactory.buildView("svg", speed, outputName + ".svg");
            try {
              view.getView(model);
            } catch (IOException e1) {
              e1.printStackTrace();
            }
            break;
          case "exit":
            System.exit(0);
            break;
          default:
            break;
        }
      }

      /**
       * Resets the shape to the original shape.
       */
      private void resetShapes() {
        List<ShapeWithGetters> tempShapes = new ArrayList<>();
        for (ShapeWithGetters shape : model.getAllShapes()) {
          Shape newShape;
          if (shape.getType().equals("Rectangle")) {
            newShape = new Rectangle(shape.getName(), shape.getAnchor(),
                    shape.getShow(), shape.getHide(),
                    shape.getColor().getRed(), shape.getColor().getGreen(),
                    shape.getColor().getBlue(),
                    shape.getPosition().getX(), shape.getPosition().getY(),
                    shape.getWidth(), shape.getHeight(),
                    shape.getIndex());
          } else {
            newShape = new Oval(shape.getName(), shape.getAnchor(),
                    shape.getShow(), shape.getHide(),
                    shape.getColor().getRed(), shape.getColor().getGreen(),
                    shape.getColor().getBlue(),
                    shape.getPosition().getX(), shape.getPosition().getY(),
                    shape.getWidth(), shape.getHeight(),
                    shape.getIndex());
          }
          tempShapes.add(new ShapeWithGetters(newShape));
        }
        currentShapes = tempShapes;
      }

      /**
       * update the shape at each tick.
       */
      void updateShapes() {
        List<ShapeWithGetters> updated = new ArrayList<>();
        for (ShapeWithGetters shape : currentShapes) {
          int r = shape.getColor().getRed();
          int g = shape.getColor().getGreen();
          int b = shape.getColor().getBlue();
          double x = shape.getPosition().getX();
          double y = shape.getPosition().getY();
          double w = shape.getWidth();
          double h = shape.getHeight();
          for (ShapeAnimationWithGetters anim : model.getAllAnimation()) {
            if (shape.getName().equals(anim.getName())
                    && anim.getStart() <= tick
                    && anim.getEnd() >= tick) {
              double[] tweenedAtt = TweenUtil.tween(anim.getFrom(), anim.getTo(),
                      tick, anim.getStart(), anim.getEnd());
              switch (anim.getAttribute()) {
                case "fill":
                  r = (int) tweenedAtt[0];
                  g = (int) tweenedAtt[1];
                  b = (int) tweenedAtt[2];
                  break;
                case "translate":
                  x = tweenedAtt[0];
                  y = tweenedAtt[1];
                  break;
                case "scale":
                  w = tweenedAtt[0];
                  h = tweenedAtt[1];
                  break;
                default:
                  break;
              }
            }
          }
          Shape newShape;
          if (shape.getType().equals("Rectangle")) {
            newShape = new Rectangle(shape.getName(), shape.getAnchor(),
                    shape.getShow(), shape.getHide(),
                    r, g, b,
                    x, y,
                    w, h,
                    shape.getIndex());
          } else {
            newShape = new Oval(shape.getName(), shape.getAnchor(),
                    shape.getShow(), shape.getHide(),
                    r, g, b,
                    x, y,
                    w, h,
                    shape.getIndex());
          }
          updated.add(new ShapeWithGetters(newShape));
        }
        this.currentShapes = updated;

        int maxW = 0;
        int maxH = 0;
        for (ShapeWithGetters shape : currentShapes) {
          double w = shape.getPosition().getX();
          double h = shape.getPosition().getY();
          if (shape.getType().equals("Rectangle")) {
            w += shape.getWidth();
            h += shape.getHeight();
          } else {
            w += shape.getWidth() / 2;
            h += shape.getHeight() / 2;
          }
          if (w > maxW) {
            maxW = (int) Math.round(w);
          }
          if (h > maxH) {
            maxH = (int) Math.round(h);
          }
        }
        animationFrame.setPreferredSize(new Dimension(maxW, maxH));
      }

      @Override
      public void paintComponent(Graphics graphic) {
        super.paintComponent(graphic);
        Graphics2D g = (Graphics2D) graphic;

        for (ShapeWithGetters shape : currentShapes) {
          if (shape.getShow() <= tick && shape.getHide() >= tick) {
            g.setColor(shape.getColor());
            if (shape.getType().equals("Rectangle")) {
              int x = (int) Math.round(shape.getPosition().getX());
              int y = (int) Math.round(shape.getPosition().getY());
              int w = (int) Math.round(shape.getWidth());
              int h = (int) Math.round(shape.getHeight());
              g.fillRect(x, y, w, h);
            } else {
              int w = (int) Math.round(shape.getWidth());
              int h = (int) Math.round(shape.getHeight());
              int x = (int) Math.round(shape.getPosition().getX() - w / 2);
              int y = (int) Math.round(shape.getPosition().getY() - h / 2);
              g.fillOval(x, y, w, h);
            }
          }
        }
      }
    }
  }

  @Override
  public void getView(ViewModel model) {
    new GUIFrame(model);
  }
}
