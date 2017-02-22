#ifndef KAREL_H
#define KAREL_H
#include "structs.h"

extern Karel karel;
extern SDL_Surface *errorImage, *karelRightImage, *karelLeftImage, *karelUpImage, *karelDownImage, *beeperImage;
extern World world;

void drawKarel(void);
void setup(void);
void run(void);
void move(void);
void turnLeft(void);
void pickBeeper(void);
void putBeeper(void);
int frontIsClear();
int frontIsBlocked();
int rightIsClear();
int rightIsBlocked();
int leftIsClear();
int leftIsBlocked();
int beepersInBag();
int noBeepersInBag();
int beepersPresent();
int noBeepersPresent();

#endif /* KAREL_H */
