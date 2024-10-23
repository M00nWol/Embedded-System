/*
 * =====================================================================================
 *
 *       Filename:  main.cu
 *
 *    Description:  image blur cpu code
 *
 *        Version:  1.0
 *        Created:  07/14/2021 10:41:21 PM
 *       Revision:  none
 *       Compiler:  nvcc
 *
 *         Author:  Yoon, Myung Kuk, myungkuk.yoon@ewha.ac.kr
 *   Organization:  EWHA Womans Unversity
 *
 * =====================================================================================
 */

#include<iostream>
#include "ppm.h"
#include "clockMeasure.h"

#define BLUR_SIZE 5

using namespace std;

const int MAX_ITER = 1;

void cpuCode(unsigned char *outArray, const unsigned char *inArray, const int w, const int h){
	for(int row=0; row <h; row++){
		for(int col=0; col<w; col++){
			float avgR = 0.0f;
			float avgG = 0.0f;
			float avgB = 0.0f;

			int pixels = 0;
			int index = 0;

			for(int rowOffset= -BLUR_SIZE; rowOffset < BLUR_SIZE + 1; rowOffset++) {
				for(int colOffset = -BLUR_SIZE;colOffset <BLUR_SIZE + 1; colOffset++){
					int curRow = row + rowOffset;
					int curCol = col + colOffset;

					if(curRow >= 0 && curRow < h && curRow>=0 && curCol < w){
						int curIndex = (curRow * w + curCol) * 3;
						avgR += inArray[curIndex];
						avgG += inArray[curIndex + 1];
						avgB += inArray[curIndex + 2];
						pixels++;
					}
				}
			}

			avgR = (unsigned char)(avgR/pixels);
			avgG = (unsigned char)(avgG/pixels);
			avgB = (unsigned char)(avgB/pixels);

			index = (row*w + col) * 3;
			outArray[index] = avgR;
			outArray[index + 1] = avgG;
			outArray[index + 2] = avgB;

		}
	}
}

int main(){
	int w, h;
	unsigned char *h_imageArray;
	unsigned char *h_outImageArray;

	//This function will load the R/G/B values from a PPM file into an array and return the width (w) and height (h).
	ppmLoad("./data/ewha_picture.ppm", &h_imageArray, &w, &h);

	size_t arraySize = sizeof(unsigned char) * h * w * 3;

	h_outImageArray = (unsigned char*)malloc(arraySize);

	clockMeasure *ckCpu = new clockMeasure("CPU CODE");

	ckCpu->clockReset();

	for(int i = 0; i < MAX_ITER; i++){
		ckCpu->clockResume();
		cpuCode(h_outImageArray, h_imageArray, w, h); 
		ckCpu->clockPause();
	}
	ckCpu->clockPrint();

	//This function will store the R/G/B values from h_outImageArray into a PPM file.
	ppmSave("ewha_picture_cpu.ppm", h_outImageArray, w, h);

	return 0;
}
