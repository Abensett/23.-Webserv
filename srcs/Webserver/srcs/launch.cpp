#include "Webserver.hpp"

#define SIGNAL_CAUGHT nb_events == -2

int		Webserver::launch(void)
{
	int					epoll_socket;
	ssize_t				nb_events;
	struct epoll_event	events[MAX_EVENTS];
	int					client_socket;
	int					j;

	if (create_epoll_socket(&epoll_socket))
		return (1);
	for (int i = 0 ; i < nb_of_servers ; ++i)
	{
		if (server[i].create_server_socket())
			return (1);
		if (server[i].bind_server_address())
			return (1);
		if (server[i].listen_for_clients())
			return (1);
		if (add_to_interest_list(&server[i], epoll_socket))
			return (1);
		std::cout << "Server " << server[i].server_socket << " is listening on " << server[i].ip << ":" << server[i].port << std::endl;
	}
	catch_signal();
	std::cout << "Waiting for new events ..." << std::endl;
	while (true)
	{
		nb_events = wait_event(epoll_socket, events);
		if (SIGNAL_CAUGHT)
			return (exit_webserv(epoll_socket));
		else if (nb_events == -1)
			return (1);
		for (ssize_t i = 0 ; i < nb_events ; ++i)
		{
			bool found = false;

			for (j = 0 ; j < nb_of_servers ; ++j)
			{
				if (events[i].data.fd == server[j].server_socket)
				{
					found = true;
					break ;
				}
			}
			if (found == true)
			{
				std::cout << "A client has just connected to the server " << server[j].ip << ":" << server[j].port << std::endl;
				if (accept_connexion(events[i].data.fd, server[j].server_address, &client_socket))
					return (1);
				if (add_client(epoll_socket, client_socket, events))
					return (1);
			}
			else
			{
				std::cout << "Event traitment" << std::endl;
				char request[1024];
				memset(request, 0, 1024);
				recv(events[i].data.fd, request, 1024, 0);
				std::cout << request << std::endl;

				FILE *html_file;
				html_file = fopen("index.html", "r");
				
				if(html_file == NULL)
    				return 1;
 
				// fseek(html_file, 0L, SEEK_END);
				// long numbytes;
				// char *buffer;
				// numbytes = ftell(html_file);
 
				// fseek(html_file, 0L, SEEK_SET);	
 

				// buffer = (char*)calloc(numbytes, sizeof(char));	
				// if(buffer == NULL)
				// 	return 1;

				// fread(buffer, sizeof(char), numbytes, html_file);
				// fclose(html_file);

				// printf("\n\n%s \n\n", buffer);

				char	header[2048] = "HTTP/1.1 200 OK\r\nContent-Type: text/html\n\n";
				// strcat(header, buffer);

				// // strcat(header,response);
				send(events[i].data.fd, header, strlen(header), 0);

				if (remove_client(epoll_socket, client_socket, events))
					return (1);
			}
		}
	}
	return (0);
};
