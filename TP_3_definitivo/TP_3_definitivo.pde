// https://youtu.be/W_lJNPRltOo

color naranja = color(255, 102, 0);
color gris = color(204, 194, 227);
boolean cambiar_vertical = false;
boolean cambiar_centro = false;
boolean cambiar_horizontal = false;
color naranja_vertical = color(255, 102, 0);
color gris_vertical = color(204, 194, 227);
color naranja_horizontal = color(255, 102, 0);
color gris_horizontal = color(204, 194, 227);
PImage img;
boolean colores_invertidos = false;
float izq_base_original = 50;
float izq_altura_original = 40;
float izq_porcentaje_achicamiento_altura = 30;
float izq_porcentaje_achicamiento_base = 0;
float izq_angulo_inicial = 30;
float izq_achicamiento_angulo = 11;
float base_original = 50;
float altura_original = 43;
float porcentaje_achicamiento_altura = 30;
float porcentaje_achicamiento_base = 0;
float angulo_inicial = 40;
float achicamiento_angulo = 11;

void setup() {
  size(800, 400);
  img = loadImage("imagen.png");  
}

void draw() {
  if (cambiar_horizontal) {
    color temp = naranja_horizontal;
    naranja_horizontal = gris_horizontal;
    gris_horizontal = temp;
  }
  if (cambiar_centro) {
    color temp = naranja;
    naranja = gris;
    gris = temp;
  }
  if (cambiar_vertical) {
    color temp = naranja_vertical;
    naranja_vertical = gris_vertical;
    gris_vertical = temp;
  }

  background(255);
  image(img, 0, 0, 400, 400);  
  for (int i = 0; i < 8; i++) {
    dibujarLineaInferior(50 * i, angulo_inicial - achicamiento_angulo * i);
  }
  for (int i = 0; i < 8; i++) {
    dibujarLineaIzquierda(50 * i, izq_angulo_inicial - izq_achicamiento_angulo * i);
  }
  reflejarInferiorASuperior();
  reflejarTrapezoideADerecha();
  color cFondo = colores_invertidos ? color(naranja) : color(gris);
  color cCentro = colores_invertidos ? color(gris) : color(naranja);
  color cFondoGrande = colores_invertidos ? color(gris) : color(naranja);
  fill(cFondoGrande);
  noStroke();
  beginShape();
  vertex(525, 263);
  vertex(676, 263);
  vertex(675, 136);
  vertex(526, 136);
  endShape(CLOSE);
  float x0 = 526;
  float y0 = 136;
  float ancho = 150;
  float alto = 127;
  float margen = 5;
  float anchoCelda = ancho / 3;
  float altoCelda = alto / 3;
  noStroke();
  for (int fila = 0; fila < 3; fila++) {
    for (int col = 0; col < 3; col++) {
      float x = x0 + col * anchoCelda + margen;
      float y = y0 + fila * altoCelda + margen;
      float anchoCelda_ = anchoCelda - 2 * margen;
      float altoCelda_ = altoCelda - 2 * margen;
      fill(cFondo);
      rect(x, y, anchoCelda_, altoCelda_);
      float anchoInterior = anchoCelda_ - porcentaje(anchoCelda_, 40);
      float altoInterior = altoCelda_ - porcentaje(altoCelda_, 40);
      float posXInterior = x + (anchoCelda_ - anchoInterior) / 2;
      float posYInterior = y + (altoCelda_ - altoInterior) / 2;
      fill(cCentro);
      rect(posXInterior, posYInterior, anchoInterior, altoInterior);
    }
  }
}
float porcentaje(float valor, float porcentaje) {
  return (valor * porcentaje / 100);
} 
float siguienteAltura(float alturaActual) {
  return alturaActual - porcentaje(alturaActual, porcentaje_achicamiento_altura);
}

void dibujarLineaIzquierda(float x, float angulo) {
  float altura_proxima = izq_altura_original;
  float altura_acumulada = 400;
  float base_proxima = izq_base_original;
  float base_acumulada = 0;
  for (int i = 0; i < 8; i++) {
    dibujarTrapezoideCompuestoRotado90(altura_acumulada, x + base_acumulada, altura_proxima, base_proxima, angulo);
    float desplazamientoX = tan(radians(angulo)) * altura_proxima;
    altura_acumulada += altura_proxima;
    altura_proxima = siguienteAltura(altura_proxima);
    base_acumulada += desplazamientoX;
    base_proxima -= porcentaje(base_proxima, izq_porcentaje_achicamiento_base);
  }
}
void dibujarTrapezoideCompuestoRotado90(float x, float y, float base, float altura, float angulo) {
  color c1 = colores_invertidos ? color(gris_horizontal) : color(naranja_horizontal);
  color c2 = colores_invertidos ? color(naranja_horizontal) : color(gris_horizontal);
  dibujarParalelogramoRotado90(x, y + altura, base, altura, radians(angulo), c1);
  dibujarParalelogramoRotado90(x + porcentaje(base, 10), y + altura - porcentaje(altura, 10), base - porcentaje(base, 50), altura - porcentaje(altura, 50), radians(angulo), c2);
  dibujarParalelogramoRotado90(x + porcentaje(base, 20), y + altura - porcentaje(altura, 15), base - porcentaje(base, 70), altura - porcentaje(altura, 70), radians(angulo), c1);
} 
void dibujarParalelogramoRotado90(float x, float y, float base, float altura, float angulo, color c) {
  float desplazamientoY = tan(angulo) * base;
  fill(c);
  stroke(0);
  beginShape();
  vertex(x, y);
  vertex(x, y - altura);
  vertex(x + base, y - altura + desplazamientoY);
  vertex(x + base, y + desplazamientoY);
  endShape(CLOSE);
}
void dibujarLineaInferior(float x, float angulo) {
  float altura_proxima = altura_original;
  float altura_acumulada = 0;
  float base_proxima = base_original;
  float base_acumulada = 400;
  for (int i = 0; i < 8; i++) {
    dibujarTrapezoideCompuesto(x + base_acumulada, altura_acumulada, base_proxima, altura_proxima, angulo);
    float desplazamientoX = tan(radians(angulo)) * altura_proxima;
    altura_acumulada += altura_proxima;
    altura_proxima = siguienteAltura(altura_proxima);
    base_acumulada += desplazamientoX;
    base_proxima -= porcentaje(base_proxima, porcentaje_achicamiento_base);
  }
} 
void dibujarTrapezoideCompuesto(float x, float y, float base, float altura, float angulo) {
  color c1 = colores_invertidos ? color(gris_vertical) : color(naranja_vertical);
  color c2 = colores_invertidos ? color(naranja_vertical) : color(gris_vertical);
  dibujarTrapezoide(x, 400 - y, base, altura, radians(angulo), c1);
  dibujarTrapezoide(x + porcentaje(base, 10), 400 - porcentaje(altura, 10) - y, base - porcentaje(base, 50), altura - porcentaje(altura, 50), radians(angulo), c2);
  dibujarTrapezoide(x + porcentaje(base, 20), 400 - porcentaje(altura, 20) - y, base - porcentaje(base, 70), altura - porcentaje(altura, 70), radians(angulo), c1);
}
void dibujarTrapezoide(float x, float y, float base, float altura, float angulo, color c) {
  float desplazamientoX = tan(angulo) * altura;
  fill(c);
  stroke(0);
  beginShape();
  vertex(x, y);
  vertex(x + base, y);
  vertex(x + base + desplazamientoX, y - altura);
  vertex(x + desplazamientoX, y - altura);
  endShape(CLOSE);
}
void reflejarInferiorASuperior() {
  int origenX = 400;
  int origenY = 264;
  int anchoSeccion = 396;
  int altoSeccion = 136;

  PImage seccion = get(origenX, origenY, anchoSeccion, altoSeccion);
  pushMatrix();
  translate(origenX, 0);
  scale(1, -1);
  image(seccion, 0, -altoSeccion);
  popMatrix();
}
void reflejarTrapezoideADerecha() {
  int origenX = 400;
  int origenY = 0;
  int anchoSeccion = 125;
  int altoSeccion = 400;
  PImage baseRect = get(origenX, origenY, anchoSeccion, altoSeccion);
  PGraphics mascara = createGraphics(anchoSeccion, altoSeccion);
  mascara.beginDraw();
  mascara.background(0);
  mascara.noStroke();
  mascara.fill(255);
  mascara.beginShape();
  mascara.vertex(0, altoSeccion);
  mascara.vertex(anchoSeccion, 265);
  mascara.vertex(anchoSeccion, 134);
  mascara.vertex(0, 0);
  mascara.endShape(CLOSE);
  mascara.endDraw();
  PImage mascaraImg = mascara.get();
  baseRect.mask(mascaraImg);
  int destinoX = 525 + 151;
  int destinoY = 0;
  pushMatrix();
  translate(destinoX + anchoSeccion, destinoY);
  scale(-1, 1);
  image(baseRect, 0, 0);
  popMatrix();
}
void mousePressed() {
  println(mouseX, mouseY);
  if (mouseX >= 0 && mouseX <= 400) {
    naranja = color(255, 102, 0);
    gris = color(204, 194, 227);
    naranja_vertical = color(255, 102, 0);
    gris_vertical = color(204, 194, 227);
    naranja_horizontal = color(255, 102, 0);
    gris_horizontal = color(204, 194, 227);
    cambiar_vertical = false;
    cambiar_centro = false;
    cambiar_horizontal = false;
    izq_base_original = 50;
    izq_altura_original = 40;
    izq_porcentaje_achicamiento_altura = 30;
    izq_porcentaje_achicamiento_base = 0;
    izq_angulo_inicial = 30;
    izq_achicamiento_angulo = 11;
    base_original = 50;
    altura_original = 43;
    porcentaje_achicamiento_altura = 30;
    porcentaje_achicamiento_base = 0;
    angulo_inicial = 40;
    achicamiento_angulo = 11;
    colores_invertidos = false;
  }
}
void keyPressed() {
  frameRate(8);
  if (key == 'a' || key == 'A') cambiar_centro = !cambiar_centro;
  if (key == 's' || key == 'S') cambiar_vertical = !cambiar_vertical;
  if (key == 'd' || key == 'D') cambiar_horizontal = !cambiar_horizontal;
}
