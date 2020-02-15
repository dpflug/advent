#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BUFSIZE 18

typedef unsigned int uint;

int main() {
  static char buffer[BUFSIZE];
  char overmatch;
  char pairs;
  unsigned int nicecount = 0;
  FILE *stream = fopen("5.txt", "r");

  while (fgets(buffer, BUFSIZE, stream)) {
    overmatch = 0;
    pairs = 0;

    for(uint i = 1; i < strlen(buffer)-1; ++i) {
      if(i > 1 && buffer[i] == buffer[i-2])
        ++overmatch;
      for(uint j = i+2; j < strlen(buffer)-1; ++j) {
        if(buffer[i] == buffer[j] && buffer[i-1] == buffer[j-1]) {
          ++pairs;
        }
      }
    }

    if(pairs > 0 && overmatch > 0) {
      ++nicecount;
    }
  }

  free(stream);
  printf("%i\n", nicecount);
}
