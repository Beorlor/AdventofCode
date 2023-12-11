#ifndef SOLUTION_H
# define SOLUTION_H

# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <fcntl.h>
# include "get_next_line.h"

typedef struct s_conv
{
	long	source;
	long	dest;
	long	range;
	struct s_conv	*next;
}	t_conv;

long	*ft_split_number(char *str);
int	ft_strncmp(const char *str1, const char *str2, size_t n);
t_conv	*ft_lstnew(long *temp);
void	ft_lstadd_back(t_conv **lst, t_conv *new);

#endif
