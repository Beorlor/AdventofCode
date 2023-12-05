#ifndef FIRST_H
# define FIRST_H

# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <fcntl.h>
# include "get_next_line.h"

long	*ft_split_number(char *str);

typedef struct s_conv
{
	long	source;
	long	dest;
	long	range;
	struct s_conv	*next;
}	t_conv;

#endif
