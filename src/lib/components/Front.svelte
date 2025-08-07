<script lang="ts">
  import type p5 from "p5";
  import P5 from "p5-svelte";

  type Props = {
    name: string;
    batch: string;
  };

  let { name, batch }: Props = $props();
  let p5Instance: p5;

  // Export p5Instance for parent component
  export { p5Instance };

  function sketch(p5: p5) {
    p5Instance = p5;
    let FONT;
    let LOGO;

    p5.preload = () => {
      FONT = p5.loadFont("/Nitz.ttf");
      LOGO = p5.loadImage("/recurse.svg");
    };

    p5.setup = () => {
      // Vertical layout: swap width and height
      p5.createCanvas(270, 428); // 2x scale for crisp rendering, vertical
      p5.pixelDensity(1);
      p5.background(255);
    };

    p5.draw = () => {
      p5.background(0); // Black background
      p5.fill(255); // White text

      // Draw large, sharp Recurse logo at top - maintain aspect ratio
      const maxLogoSize = p5.width * 0.6;
      const logoAspect = LOGO.width / LOGO.height;
      let logoW, logoH;

      if (logoAspect > 1) {
        // Wider than tall
        logoW = maxLogoSize;
        logoH = maxLogoSize / logoAspect;
      } else {
        // Taller than wide or square
        logoH = maxLogoSize;
        logoW = maxLogoSize * logoAspect;
      }

      const logoX = p5.width / 2 - logoW / 2;
      const logoY = p5.height * 0.1;

      // Disable smoothing for sharp pixel-perfect rendering
      p5.noSmooth();
      p5.image(LOGO, logoX, logoY, logoW, logoH);

      // Re-enable smoothing for text
      p5.smooth();

      // Draw name in middle with text wrapping
      p5.textFont(FONT);
      p5.textAlign(p5.CENTER, p5.CENTER);
      p5.textSize(p5.width * 0.12);

      const maxWidth = p5.width * 0.9; // Leave 10% margin
      const words = name.split(" ");
      const lines = [];
      let currentLine = "";

      // Simple word wrapping
      for (const word of words) {
        const testLine = currentLine + (currentLine ? " " : "") + word;
        const testWidth = p5.textWidth(testLine);

        if (testWidth > maxWidth && currentLine) {
          lines.push(currentLine);
          currentLine = word;
        } else {
          currentLine = testLine;
        }
      }
      if (currentLine) lines.push(currentLine);

      // Draw wrapped text
      const lineHeight = p5.textSize() * 0.9; // Tighter line height
      const startY = p5.height * 0.6 - ((lines.length - 1) * lineHeight) / 2;

      lines.forEach((line, i) => {
        p5.text(line, p5.width / 2, startY + i * lineHeight);
      });

      // Draw batch below name
      p5.textSize(p5.width * 0.08);
      p5.text(batch, p5.width / 2, p5.height * 0.84);

      // Draw "RECURSE CENTER" at bottom
      p5.textSize(p5.width * 0.06);
      p5.text("NEVER GRADUATE", p5.width / 2, p5.height * 0.9);
    };
  }
</script>

<div class="canvas-wrapper rounded-xl overflow-clip">
  <P5 {sketch} />
</div>

<style>
  .canvas-wrapper {
    width: 54mm; /* Swap dimensions for vertical */
    height: 85.6mm;
    border: 1px solid #ccc;
  }

  .canvas-wrapper :global(canvas) {
    width: 100% !important;
    height: 100% !important;
    image-rendering: auto; /* Better for text and logo */
  }
</style>
