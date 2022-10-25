#include <stdio.h>
#include <stdlib.h>
#include<string.h>
int main()
{
  			FILE *html_file;
	html_file = fopen("index.html", "r");
	
	if(html_file == NULL)
    		return 1;
 
	fseek(html_file, 0L, SEEK_END);
	long numbytes;
	char *buffer;
	numbytes = ftell(html_file);
 
	fseek(html_file, 0L, SEEK_SET);	
 

	buffer = (char*)calloc(numbytes, sizeof(char));	
	if(buffer == NULL)
		return 1;

	fread(buffer, sizeof(char), numbytes, html_file);
	fclose(html_file);
				char	header[2048] = "Content-Type: text/html\n\n";

				printf("\n\n%s \n\n", header);
        return 0;
}
