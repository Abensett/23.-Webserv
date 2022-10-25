#include <stdio.h>
int main()
{
    	FILE *html_file;
		html_file = fopen("index.html", "r");
		
		char response[1024];	
		fgets(response, , html_file);
		printf("\n\n%s \n\n", response);
        fclose(html_file);
        return 0;
}
