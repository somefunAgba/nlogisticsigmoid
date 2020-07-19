/*
 * File: nlsig.h
 *
 * C/C++ source code
 */
#ifndef NLSIG_H
#define NLSIG_H

/* Include Files */
//#include <stdint.h>
//#include <stddef.h>
//#include <stdlib.h>
#include <Arduino.h>
#include "fasta_exp.h"

/* Function Declarations */

nlsig(double& y, double& dy_dx, double x, 
		const double xmax, const double xmin, double ymax, double ymin,
		const int n=1, const double lambda=6, const int safety=0, const unsigned char isreverse=0);

#endif

/*
 * File trailer for nlsig.h
 *
 * [EOF]
 */
