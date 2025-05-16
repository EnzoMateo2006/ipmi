PImage portada;
PImage diapo1;
PImage diapo2;
PImage diapo3;
PImage diapo4;
PFont tipografiadiapo4;
PFont tipografianormal;
int ancho = 64;
int alto = 48;
int tamañotexto = 10;
int desplazamiento = 0;
boolean empujar = false;
boolean mostrardiapo2 = false;
int aparece = 0;
int textoY;
boolean subirtexto = false;
int tiempodiapo2 = 0;
boolean aparecediapo3 = false;
int diapo3Y;
int posXtextodiapo3;
int lugartextodiapo3;
int posYtextodiapo3;
boolean aparecetextodiapo3 = false;
int posXtexto2diapo3;
int lugartexto2diapo3;
int posYtexto2diapo3;
boolean aparecetexto2diapo3 = false;
int posYtexto3diapo3;
int lugartexto3diapo3;
boolean aparecetexto3diapo3 = false;
boolean apareceDiapo4 = false;
int diapo4X;
boolean textodiapo4 = false;
int duracióndiapo3 = 0;
boolean apareceelboton = false;
int duracióndiapo4 = 0;
boolean arribadelboton = false;

void setup() {
size(640, 480);
portada = loadImage("imagen1.png");
diapo1 = loadImage("imagen2.png");
diapo2 = loadImage("imagen3.png");
diapo3 = loadImage("imagen4.png");
diapo4 = loadImage("imagen5.png");
tipografiadiapo4 = loadFont("ComicSansMS-Italic-48.vlw");
tipografianormal = createFont("SansSerif", 32);
textFont(tipografianormal);
textAlign(CENTER, CENTER);
textoY = height + 50;
diapo3Y = height;
posXtextodiapo3 = -300;
lugartextodiapo3 = width / 2;
posYtextodiapo3 = height / 2 - 60;
posXtexto2diapo3 = width + 300;
lugartexto2diapo3 = width / 2;
posYtexto2diapo3 = posYtextodiapo3 + 40;
posYtexto3diapo3 = height + 100;
lugartexto3diapo3 = posYtexto2diapo3 + 40;
diapo4X = width;
}
void draw() {
background(255);
if (ancho >= width && alto >= height && tamañotexto >= 48) {
if (!empujar) {
empujar = true;
aparece = frameCount;
}
}
if (empujar && desplazamiento < width) {
desplazamiento += 2;
}
if (empujar && !mostrardiapo2) {
int diapo1X = -diapo1.width + desplazamiento;
image(diapo1, diapo1X, 0);
textAlign(LEFT, CENTER);
fill(255);
textSize(32);
text("La novela narra la vida de una niña durante \nla dictadura argentina, marcada por la \nclandestinidad y el miedo.", 20, height / 2);
if (frameCount - aparece > 600) {
mostrardiapo2 = true;
subirtexto = true;
tiempodiapo2 = frameCount;
}
}
if (mostrardiapo2) {
image(diapo2, 0, 0, width, height);
if (subirtexto) {
if (textoY > height / 2) {
textoY -= 2;
} else {
textoY = height / 2;
subirtexto = false;
}
}
fill(255);
textSize(30);
textAlign(CENTER, CENTER);
text("La protagonista y su madre se mudan \na una falsa granja que oculta \nuna imprenta clandestina de Montoneros.", width / 2, textoY);
if (frameCount - tiempodiapo2 > 540) {
aparecediapo3 = true;
}
}
if (aparecediapo3) {
if (diapo3Y > 0) {
diapo3Y -= 4;
} else {
if (duracióndiapo3 == 0) {
duracióndiapo3 = frameCount;
}
diapo3Y = 0;
aparecetextodiapo3 = true;
aparecetexto2diapo3 = true;
aparecetexto3diapo3 = true;
}
image(diapo3, 0, diapo3Y, width, height);
}
if (aparecetextodiapo3 && posXtextodiapo3 < lugartextodiapo3) {
posXtextodiapo3 += 4;
}
if (aparecetexto2diapo3 && posXtexto2diapo3 > lugartexto2diapo3) {
posXtexto2diapo3 -= 4;
}
if (aparecetexto3diapo3 && posYtexto3diapo3 > lugartexto3diapo3) {
posYtexto3diapo3 -= 4;
}
fill(255);
textSize(28);
textAlign(CENTER, CENTER);
if (aparecetextodiapo3) text("La niña aprende a vivir en secreto,", posXtextodiapo3, posYtextodiapo3);
if (aparecetexto2diapo3) text("bajo normas estrictas,", posXtexto2diapo3, posYtexto2diapo3);
if (aparecetexto3diapo3) text("en un ambiente tenso y peligroso.", width / 2, posYtexto3diapo3);
if (duracióndiapo3 != 0 && frameCount - duracióndiapo3 > 480) {
apareceDiapo4 = true;
}
if (apareceDiapo4) {
if (diapo4X > 0) {
diapo4X -= 6;
} else {
diapo4X = 0;
textodiapo4 = true;
}
image(diapo4, diapo4X, 0, width, height);
}
if (textodiapo4) {
textFont(tipografiadiapo4);  
fill(255);
textSize(26);
textAlign(CENTER, CENTER);
text("Con el aumento de la represión, la madre es detenida\ny la niña debe huir del país para sobrevivir.", width / 2, height - 60);
textFont(tipografianormal);  
if (duracióndiapo4 == 0) duracióndiapo4 = frameCount;
if (frameCount - duracióndiapo4 > 300) apareceelboton = true;
}
if (apareceelboton) {
arribadelboton = mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > height / 2 - 25 && mouseY < height / 2 + 25;
if (arribadelboton) {
fill(255, 0, 0);
} else {
fill(230, 0, 80);
}
rect(width / 2 - 100, height / 2 - 25, 200, 50, 10);
fill(255);
textSize(20);
textAlign(CENTER, CENTER);
text("Volver a ver", width / 2, height / 2);
}
int x = (width - ancho) / 2 + desplazamiento;
int y = (height - alto) / 2;
image(portada, x, y, ancho, alto);
textAlign(CENTER, CENTER);
fill(45);
textSize(tamañotexto);
text("La casa de los conejos", width / 2 + desplazamiento, height / 2);
if (ancho < width) ancho += 4;
if (alto < height) alto += 3;
if (tamañotexto < 48) tamañotexto += 1;
}
void mousePressed() {
if (apareceelboton && arribadelboton) {
ancho = 64;
alto = 48;
tamañotexto = 10;
desplazamiento = 0;
empujar = false;
mostrardiapo2 = false;
aparece = 0;
textoY = height + 50;
subirtexto = false;
tiempodiapo2 = 0;
aparecediapo3 = false;
diapo3Y = height;
posXtextodiapo3 = -300;
posXtexto2diapo3 = width + 300;
posYtexto3diapo3 = height + 100;
apareceDiapo4 = false;
diapo4X = width;
textodiapo4 = false;
duracióndiapo3 = 0;
apareceelboton = false;
duracióndiapo4 = 0;
aparecetextodiapo3 = false;
aparecetexto2diapo3 = false;
aparecetexto3diapo3 = false;
textFont(tipografianormal);  
}
}
