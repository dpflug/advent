#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BUFSIZE 18

int main() {
  static char buffer[BUFSIZE];
  FILE *stream = fopen("5.txt", "r");
  unsigned char vowels;
  char homobigram;
  char naughty_string;
  char lastletter;
  int nicecount = 0;

  while (fgets(buffer, BUFSIZE, stream)) {
    naughty_string = 0;
    homobigram = 0;
    vowels = 0;
    lastletter = '\n';

    for(unsigned int i = 0; i < strlen(buffer); ++i) {
      char c = buffer[i];

      if(c == lastletter)
        ++homobigram;
      if((c == 'b' || c == 'd' || c == 'q' || c == 'y') && c-1 == lastletter)
        ++naughty_string;
      if(c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u')
        ++vowels;

      lastletter = c;

      if(i == strlen(buffer)-1 && vowels >= 3 && homobigram > 0 && naughty_string == 0)
        ++nicecount;
    }
  }

  free(stream);
  printf("%i\n", nicecount);
}
