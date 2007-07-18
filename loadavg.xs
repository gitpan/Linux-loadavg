#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "stdlib.h"

MODULE = Linux::loadavg		PACKAGE = Linux::loadavg		

void
loadavg(nelem=3)
   int nelem;
PREINIT:
   double *loadavg;
   int     rc, i;
PPCODE:
   if (nelem > 3 || nelem < 1)
      croak("invalid nelem (%d)", nelem);
   New(0, loadavg, sizeof(double)*nelem, double);
   if ((rc = getloadavg(loadavg, nelem)) != nelem)
      croak("getloadavg failed (%d)", rc);
   EXTEND(SP, nelem);
   for(i=0; i<nelem; i++)
      PUSHs(sv_2mortal(newSVnv(loadavg[i])));
