#include "Location.hpp"

int	Location::set_directory_listing(std::vector<std::string> & vector, size_t & i)
{
	if (directory_listing_set == true)
		return (error("Syntax error : multiple directory_listing directives in the same location context."));
	if (invalid_directive_len(vector, i, ";", 3, 3))
		return (error("Syntax error : invalid directory_listing directive."));
	++i;
	if (vector[i] == "on")
		_directory_listing = true;
	else if (vector[i] == "off")
		_directory_listing = false;
	else
		return (error("Syntax error : invalid directory_listing directive."));
	if (vector[++i] != ";")
		return (error("Syntax error : the root directive doesn't ends by ';'."));
	directory_listing_set = true;
	return (0);
};
