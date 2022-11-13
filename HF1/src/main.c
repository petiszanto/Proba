#include "em_device.h"
#include "em_chip.h"
#include "time.h"

#include "em_emu.h"
#include "em_cmu.h"
#include "em_lcd.h"
#include "em_gpio.h"
#include "em_rtc.h"

#include "segmentlcd_individual.h"
#include "caplesense.h"
#include "vddcheck.h"


#define CMU_BASE_ADDR 0x400c8000
#define TIMER0_ADDR 0x40010000
#define GPIO_BASE_ADDR 0x40006000

#define GPIO_PB_MODEH (*(volatile unsigned int *)(GPIO_BASE_ADDR+0x02C))
#define GPIO_PB_DIN (*(volatile unsigned int *)(GPIO_BASE_ADDR+0x040))

#define CMU_HFRERCLKEN0 (*(volatile unsigned int *)(CMU_BASE_ADDR+0x044))
#define TIMER0_CTRL (*(volatile unsigned int *)(TIMER0_ADDR+0x000)) //542
#define TIMER0_TOP (*(volatile unsigned int *)(TIMER0_ADDR+0x01C)) //542
#define TIMER0_STATUS (*(volatile unsigned int *)(TIMER0_ADDR+0x008)) //542
#define TIMER0_DTOGEN (*(volatile unsigned int *)(TIMER0_ADDR+0x07C)) //542
#define TIMER0_CNT (*(volatile unsigned int *)(TIMER0_ADDR+0x024)) //542

enum dir {down, forward, up};

volatile enum dir cdir = forward;
  volatile enum dir ndir;
  volatile int cpos=1088;
  volatile int npos;
  volatile int cdigit=0;
  volatile int points=0;
  volatile int lose2;
  volatile int crash=1;
  volatile int meteor1,meteor2,meteor3;
  volatile int location=10880;
  volatile int dchange;
  volatile int randSegment,randDigit; //uint8_t
  SegmentLCD_LowerCharSegments_TypeDef map[7];
  volatile int meteor_Reset;
  time_t t;
volatile uint32_t msTicks;
void SysTick_Handler(void)
{
 // msTicks++;       /* increment counter necessary in Delay()*/
            if(dchange==1)
                      {
                          if(cdigit==6)
                          {
                        	  meteor_Reset=1;
                        	  map[cdigit].raw-=cpos; //torli az urhajot a digitrol
                              cdigit=0; //reseteli a digit szamlalot
                              map[cdigit].raw+=npos;
                              points=points+1; //noveli a pontunkat

                          }
                          else{
                              cdigit++; //kovetkezo digitre lepes
                          	  	  map[cdigit].raw+=npos; //a kovetkezo digitre kirakja az urhajot
                                                map[cdigit-1].raw-=cpos;//az elozo digitrol torli az urhajot
                          }
                      }
            else{
            map[cdigit].raw-=cpos; //a kovetkezo digitre kirakja az urhajot
            map[cdigit].raw+=npos;//az elozo digitrol torli az urhajot
            }
            if(meteor_Reset)
            {
            	all_meteor_generator();
            	meteor_Reset=0;
            }
            SegmentLCD_LowerSegments(map);//kiírás a kijelzõre
            cdir=ndir;//az uj irany lesz a mostani irany
            cpos=npos;//az uj helye lesz a mostani heyle
            location=cpos*10+cdigit;//az urhajo poziciojanak mentese utkozeshez
}

/*void Delay(uint32_t dlyTicks)
{
  uint32_t curTicks;

  curTicks = msTicks;
  while ((msTicks - curTicks) < dlyTicks) ;
}*/




enum dir direction_change(enum dir current_direction) //jelenlegi menetiránybol és bementbol megmondja merre fog allni lepes utan
{
	int sliderPos = CAPLESENSE_getSliderPosition();//-1-48ig ker le erteket
	CAPLESENSE_Sleep();
	int Slider_Mid_Value=24; //közepso ertek
	if(sliderPos==-1) // nem jött bemenet
		return current_direction; // nincs irányvaltas
	enum dir new_direction;
	if(sliderPos<Slider_Mid_Value){ //alsó erintes
		if(current_direction != up) //ha nem veg pozicioban all
			new_direction = current_direction+1;// fordulas balra
		else new_direction=current_direction; // ha nem fordulhat ignoralja a bemenetet
	}
		  else if(sliderPos>Slider_Mid_Value){
			if(current_direction != down) //ha nem veg pozicioban all
				new_direction = current_direction-1;// fordulas balra ha nem veg pozicioban all
			else new_direction=current_direction; // ha nem fordulhat ignoralja a bemenetet
			}
			return new_direction; //visszaadja a lepes utani uj iranyt
}

void crash_checker(void)//megomondja történt-e ütközés
{
	//nem történt ütközés 0
	//1 ha történt ütközés
		if(!(location-meteor1))
			crash=1;
		if(!(location-meteor2))
				crash=1;
		if(!(location-meteor3))
				crash=1;
}

int lose(void)
{

	if(crash==1){

	return 1;}
	else return 0;
}


int digit_change(enum dir current_direction)//megmondja kell-e digitet valtani
{
	if(current_direction==forward)//csak akkor van valtas ha elore all
		return 1;//1:kell valtani
	else return 0;//0:nem kell valtani
}

int next_position_generator(int current_position,enum dir current_direction,enum dir new_direction)
{
	int next_position;
	if((current_direction==forward) && (new_direction==forward))
	{
		next_position=current_position;
		return next_position;
	}
	else if(((current_direction==up) && (new_direction==up))||((current_direction==down) && (new_direction==down)))
	{
		if(current_position==16){
			next_position=32;}
		else{
			next_position=16;}
	}
	else if((current_direction==up) && (new_direction==forward))
	{
		if(current_position==16){
					next_position=1088;}
				else{
					next_position=1;}
	}
	else if((current_direction==down) && (new_direction==forward))
	{
		if(current_position==16){
					next_position=8;}
				else{
					next_position=1088;}
	}
	else if((current_direction==forward) && (new_direction==down))
	{
		if(current_position==1088){
							next_position=16;}
						else{
							next_position=32;}
	}
	else if((current_direction==forward) && (new_direction==up))
		{
			if(current_position==1088){
								next_position=32;}
							else{
								next_position=16;}

		}
	return next_position;
}



void numeric_meteor_generator(void)
{
	uint8_t randSegmentNumb;
	randDigit = rand() % 6;
	randSegmentNumb = rand() % 5;
	switch(randSegmentNumb)
	{
	case 0: randSegment=1; break;
	case 1: randSegment=8; break;
	case 2: randSegment=16; break;
	case 3: randSegment=32; break;
	case 4: randSegment=1088; break;
	}
}

void all_meteor_generator(void)
{
	map[(meteor1%10)].raw-=meteor1/10;
		map[(meteor2%10)].raw-=meteor2/10;
		map[(meteor3%10)].raw-=meteor3/10;
	//int meteor1digit=2,meteor2digit=3,meteor3digit=5;
	numeric_meteor_generator();
		  meteor1=randSegment*10+randDigit+1;//10882; //egy intel meteor1=10882; %10 es /10
		  numeric_meteor_generator();
		  meteor2=randSegment*10+randDigit+1;//10883;
		  numeric_meteor_generator();
		meteor3=randSegment*10+randDigit+1;//10885;
	//if(meteor1%10==meteor2%10 & meteor2%10==meteor3%10){}
	map[meteor1%10].raw+=meteor1/10;
	map[meteor2%10].raw+=meteor2/10;
	map[meteor3%10].raw+=meteor3/10;
}

void first_meteor_generator(void)
{
	//int meteor1digit=2,meteor2digit=3,meteor3digit=5;
	numeric_meteor_generator();
		  meteor1=randSegment*10+randDigit+1;//10882; //egy intel meteor1=10882; %10 es /10
		  numeric_meteor_generator();
		  meteor2=randSegment*10+randDigit+1;//10883;
		  numeric_meteor_generator();
		meteor3=randSegment*10+randDigit+1;//10885;
	if(meteor1%10==meteor2%10 & meteor2%10==meteor3%10)
	{

	}
	map[meteor1%10].raw+=meteor1/10;
	map[meteor2%10].raw+=meteor2/10;
	map[meteor3%10].raw+=meteor3/10;
}



int main(void)
{


  // Chip errata /
  CHIP_Init();
  CMU_HFRCOBandSet(cmuHFRCOBand_1MHz);
  SegmentLCD_Init(false);   // Enable LCD without voltage boost
  CAPLESENSE_Init(false);  //CAPLESENSE_setupLESENSE(true);
  /* Setup SysTick Timer for 1 msec interrupts  */
    if (SysTick_Config(CMU_ClockFreqGet(cmuClock_CORE))) {
      while (1) ;
    }

    srand((unsigned)time(&t));
  for(int j=0;j<7;j++){
  	map[j].raw = 0;}
  map[0].raw = 1088;
  first_meteor_generator();
  meteor_Reset=0;
  SegmentLCD_LowerSegments(map);


  //int en=0;
  /*CMU_HFRERCLKEN0 |= 1<<5; //CLK engedelyezese 150oldal(5,6,7,8) timerek
  	  	  	  TIMER0_CTRL |= 0<<24;//543
  			  TIMER0_CTRL |= 1<<25;//543
			  TIMER0_CTRL |= 0<<26;//543
			  TIMER0_CTRL |= 1<<27;//543
			  TIMER0_TOP=3000;//550
			  TIMER0_STATUS|=1<<2;
			  TIMER0_DTOGEN|=1<<3;//558 */

  // Infinite loop
  while (1) {
	  ndir = direction_change(cdir);
	  	 dchange=digit_change(cdir);
	  	            npos=next_position_generator(cpos,cdir,ndir);
	  /*lose2=lose();

	  npos=next_position_generator(cpos,cdir,ndir);
	  if(dchange==1)
	  		  {
	  			  if(cdigit==7)
	  			  {
	  				  cdigit=0;
	  				  points=points+1;
	  			  }
	  			  else
	  				  cdigit++;
	  		  }
	  		  map[cdigit].raw=npos;
	  		  map[cdigit-1].raw=0;
	  SegmentLCD_LowerSegments(map);
	  cdir=ndir;
	  cpos=npos;
	  */
  }
}
