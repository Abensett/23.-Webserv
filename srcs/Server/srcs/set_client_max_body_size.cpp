#include "Server.hpp"

int	Server::set_client_max_body_size(std::string & str)
{
	size_t	i = 0;
	size_t	len = 0;

	if (str.empty())
		return (error("Syntax error : client_max_body_size."));
	while (str[i] && str[i] >= '0' && str[i] <= '9')
	{
		_client_max_body_size = _client_max_body_size * 10 + str[i++] - '0';
		if (++len == 10)
			return (error("Syntax error : client_max_body_size may overflow. (You can use d, h, k, m, g, t to convert your client_max_body_size directive.)"));
	}
	if (i == 0)
		return (error("Syntax error : client_max_body_size."));
	else if (str[i] == '\0')
		return (0);
	else
	{
		if (str[i + 1] != '\0')
			return (error("Syntax error : client_max_body_size."));
		else if ((str[i] == 'd' || str[i] == 'D'))
			_client_max_body_size *= 1e1;
		else if ((str[i] == 'h' || str[i] == 'H'))
			_client_max_body_size *= 1e2;
		else if ((str[i] == 'k' || str[i] == 'K'))
			_client_max_body_size *= 1e3;
		else if ((str[i] == 'm' || str[i] == 'M'))
			_client_max_body_size *= 1e6;
		else if ((str[i] == 'g' || str[i] == 'G'))
			_client_max_body_size *= 1e9;
		else if ((str[i] == 't' || str[i] == 'T'))
			_client_max_body_size *= 1e12;
		else
			return (error("Syntax error : client_max_body_size."));
	}
	return (0);
}

int	Server::set_client_max_body_size(std::vector<std::string> & token_vector, size_t & i)
{
	if (client_max_body_size_set)
		return (error("Syntax error : Multiples client_max_body_size declaractions in the same server"));
	if (invalid_directive_len(token_vector, i, ";", 3, 3))
		return (error("Syntax error : invalid client_max_body_size directive."));
	else if (set_client_max_body_size(token_vector[++i]))
		return (1);
	else if (token_vector[++i] != ";")
		return (error("Syntax error : the client_max_body_size directive doesn't ends by ';'."));
	client_max_body_size_set = true;
	return (0);
}
