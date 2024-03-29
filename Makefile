# **************************************************************************** #
#                              EXECUTABLE'S NAME                               #
# **************************************************************************** #


NAME			 = webserv

CONFIG_FILE		 = configuration_files/main.conf



# **************************************************************************** #
#                                 COMPILATION                                  #
# **************************************************************************** #


CC				 = c++

CFLAGS			 = -Wall -Wextra -Werror -std=c++98

LFLAGS			 = -Wall -Wextra -Werror -std=c++98

INCLUDES		 = -I includes



# **************************************************************************** #
#                                    DEBUG                                     #
# **************************************************************************** #


DEBUG			 = false

ifeq ($(DEBUG), true)

	CFLAGS		+= -g3

	LFLAGS		+= -g3

else

	CFLAGS		+= -O3

	LFLAGS		+= -O3

endif

VALGRIND_FLAGS	 = --leak-check=full --show-leak-kinds=all --track-fds=yes



# **************************************************************************** #
#                                 SOURCE FILES                                 #
# **************************************************************************** #


SRC_ROOTDIR		= srcs/

SRC_SUBDIR	    = $(MAIN) \
				  $(addprefix Webserver/srcs/, $(WEBSERVER)) \
				  $(addprefix Server/srcs/, $(SERVER)) \
				  $(addprefix Server/Error_page/srcs/, $(ERROR_PAGE)) \
				  $(addprefix Server/Location/srcs/, $(LOCATION)) \
				  $(addprefix Client/srcs/, $(CLIENT)) \
				  $(addprefix Request/srcs/, $(REQUEST)) \
				  $(addprefix Response/srcs/, $(RESPONSE)) \
				  $(addprefix Utils/srcs/, $(UTILS))

MAIN			= main.cpp

WEBSERVER		= parsing/remove_commentaries.cpp \
				  parsing/replace_blank_characters.cpp \
				  parsing/separate_braces.cpp \
				  parsing/separate_semicolon.cpp \
				  parsing/parse.cpp \
				  parsing/parse_configuration_file.cpp \
				  parsing/parse_server.cpp \
				  parsing/print_config.cpp \
				  parsing/split_strings.cpp \
				  parsing/usage.cpp \
				  catch_signal.cpp \
				  client_connection.cpp \
				  client_error.cpp \
				  client_recv.cpp \
				  client_send.cpp \
				  constructor.cpp \
				  destructor.cpp \
				  exit_webserv.cpp \
				  init_sockets.cpp \
				  launch.cpp \
				  new_events.cpp

UTILS			= error.cpp \
				  invalid_directive_len.cpp \
				  print.cpp \
				  itostring.cpp \
				  only_digit.cpp \
				  set_ip_and_port.cpp \
				  check_file_RWrights.cpp

SERVER			= constructor.cpp \
				  parse.cpp \
				  set_listen.cpp \
				  set_server_names.cpp \
				  set_client_max_body_size.cpp \
				  set_error_page.cpp \
				  set_location.cpp \
				  getters.cpp \
				  destructor.cpp

ERROR_PAGE		= constructor.cpp \
				  destructor.cpp \
				  get_file.cpp \
				  getters.cpp

LOCATION		= constructor.cpp \
				  destructor.cpp \
				  getters.cpp \
				  set_allow_methods.cpp \
				  set_cgi.cpp \
				  set_directory_file.cpp \
				  set_directory_listing.cpp \
				  set_index.cpp \
				  parse.cpp \
				  set_redirection.cpp \
				  set_root.cpp \
				  set_upload.cpp \
				  set_upload_path.cpp

REQUEST			= constructor.cpp \
				  destructor.cpp \
				  getters.cpp \
				  get_content.cpp \
				  is_ready.cpp \
				  modifiers.cpp \
				  request_body.cpp \
				  request_header.cpp \
				  request_line.cpp

CLIENT			= add_to_request.cpp \
				  constructor.cpp \
				  create_response.cpp \
				  destructor.cpp \
				  getters.cpp \
				  request_is_ready.cpp \
				  setters.cpp

RESPONSE		= constructor.cpp \
				  delete.cpp \
				  destructor.cpp \
				  directory_listing.cpp \
				  expect_100_continue.cpp \
				  generate_100_continue.cpp \
				  generate_cgi_response.cpp \
				  generate_error_page.cpp \
				  get.cpp \
				  get_location.cpp \
				  getters.cpp \
				  has_content.cpp \
				  header_too_large.cpp \
				  main_create.cpp \
				  method_not_implemented.cpp \
				  method_not_allowed.cpp \
				  post.cpp \
				  request_block_not_ok.cpp \
				  update.cpp \
				  uri_too_long.cpp

SRCS			= $(addprefix $(SRC_ROOTDIR), $(SRC_SUBDIR))



# **************************************************************************** #
#                                 OBJECT FILES                                 #
# **************************************************************************** #


OBJ_ROOTDIR		= objs/

OBJ_SUBDIR		= $(SRC_SUBDIR:.cpp=.o)

OBJ_DIR 		= $(shell find ./srcs -type d | sed s/srcs/objs/)

OBJS			= $(addprefix $(OBJ_ROOTDIR), $(OBJ_SUBDIR))

DEPENDS			:= $(OBJS:.o=.d)



# **************************************************************************** #
#                                    COLORS                                    #
# **************************************************************************** #


GREEN		= \033[32;1m
RED			= \033[31;1m
YELLOW		= \033[33;1m
CYAN		= \033[36;1m
RESET		= \033[0m
WHITE 		= \033[0;m
CLEAR		= \033[2K\r



# **************************************************************************** #
#                               MAKEFILE'S RULES                               #
# **************************************************************************** #


.SILENT : 		all

all : 			header $(NAME) footer
				@valgrind $(VALGRIND_FLAGS) ./$(NAME) $(CONFIG_FILE)

$(OBJ_ROOTDIR)%.o: $(SRC_ROOTDIR)%.cpp
				@mkdir -p $(OBJ_DIR)
				$(CC) $(CFLAGS) $(INCLUDES) -MMD -MP -c $< -o $@

$(NAME)	:		$(OBJS)
				@printf "\n"
				$(CC) $(LFLAGS) $(OBJS) -o $(NAME)
				@printf "\n"

leaks :			$(NAME)
				@valgrind $(VALGRIND_FLAGS) ./$(NAME) $(CONFIG_FILE)

run :			$(NAME)
				@./$(NAME) $(CONFIG_FILE)

clean :
				@rm -rf $(OBJ_ROOTDIR) $(DEPENDS)
				@printf "$(RED)"
				@printf "Object files removed\n"
				@printf "$(RESET)"

fclean :
				@-rm -f $(NAME)
				@-rm -rf $(OBJ_ROOTDIR) $(DEPENDS)
				@printf "$(RED)"
				@printf "Binary and object files removed\n"
				@printf "$(RESET)"

re :			fclean all

header :
				@printf "$(CYAN)"
				@printf "__        _______ ____ ____  _____ ______     __\n"
				@printf "\ \      / / ____| __ ) ___|| ____|  _ \ \   / /\n"
				@printf " \ \ /\ / /|  _| |  _ \___ \|  _| | |_) \ \ / / \n"
				@printf "  \ V  V / | |___| |_) |__) | |___|  _ < \ V /  \n"
				@printf "   \_/\_/  |_____|____/____/|_____|_| \_\ \_/   \n"
				@printf "$(RESET)\n"

footer :
				@printf "$(CYAN)"
				@printf "➤ COMPILATION SUCCESS\n"
				@printf "[$(RESET)OK$(CYAN)]$(RESET) webserv generated.$(CYAN)\n"
				@printf "\nUSAGE :\n"
				@printf "$(RESET)"
				@printf "./$(NAME) [configuration file]\n"


-include $(DEPENDS)


.PHONY : 		all clean fclean bonus re
