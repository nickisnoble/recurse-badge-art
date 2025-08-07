<script lang="ts">
  import type p5 from "p5";
  import P5 from "p5-svelte";

  type Props = {
    name: string;
  };

  let { name }: Props = $props();

  const ALPHABET = "abcdefghijklmnopqrstuvwxyz".split("");

  function alphaOrder(char: string) {
    return ALPHABET.indexOf(char.toLowerCase());
  }

  function sketch(p5: p5) {
    const bayer8 = [
      [0, 32, 8, 40, 2, 34, 10, 42],
      [48, 16, 56, 24, 50, 18, 58, 26],
      [12, 44, 4, 36, 14, 46, 6, 38],
      [60, 28, 52, 20, 62, 30, 54, 22],
      [3, 35, 11, 43, 1, 33, 9, 41],
      [51, 19, 59, 27, 49, 17, 57, 25],
      [15, 47, 7, 39, 13, 45, 5, 37],
      [63, 31, 55, 23, 61, 29, 53, 21],
    ];
    const screenSize = 8;
    let FONT;

    p5.preload = () => {
      FONT = p5.loadFont("/Nitz.ttf");
    };

    p5.setup = () => {
      p5.createCanvas(85.6 * 5, 54.0 * 5);
      p5.pixelDensity(1);
      p5.background(255);
    };

    p5.draw = () => {
      const chars = name.split("");
      const count = chars.length;
      const ctx = p5.drawingContext;
      const w = p5.width / count;

      chars.forEach((char, i) => {
        let offset = Math.floor((p5.width / count) * i);
        let order = alphaOrder(char);

        let cx = offset + w / 2;
        let cy = order >= 0 ? (p5.height / 26) * order : p5.height / 2;
        let r = order >= 0 ? p5.height / 2 : p5.height;

        let gradient = ctx.createRadialGradient(cx, cy, 0, cx, cy, r);
        gradient.addColorStop(0, order === -1 ? "white" : `black`);
        gradient.addColorStop(1, order === -1 ? "black" : `white`);

        ctx.fillStyle = gradient;

        p5.noStroke();
        p5.shearX(p5.radians(-8));
        p5.rect(offset, 0, w, p5.height);
        p5.shearX(p5.radians(8));
      });

      p5.loadPixels();

      for (let y = 0; y < p5.height; y++) {
        for (let x = 0; x < p5.width; x++) {
          let i = 4 * (x + y * p5.width);
          let gray =
            p5.pixels[i] * 0.299 +
            p5.pixels[i + 1] * 0.587 +
            p5.pixels[i + 2] * 0.114;

          let thresh = bayer8[y % screenSize][x % screenSize] * (255 / 64);
          let val = gray < thresh ? 0 : 255;

          p5.pixels[i] = p5.pixels[i + 1] = p5.pixels[i + 2] = val;
        }
      }

      p5.updatePixels();

      p5.push();
      p5.translate(p5.width, p5.height);
      p5.rotate(p5.radians(-90));
      p5.strokeWeight(8);
      p5.stroke(255);
      p5.textFont(FONT);
      p5.textSize(32);
      p5.textAlign(p5.LEFT, p5.BOTTOM);
      p5.text("RECURSE.COM", 0, 0);
      p5.pop();
    };
  }
</script>

<P5 {sketch} />
