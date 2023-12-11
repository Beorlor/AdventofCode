#include "Solution.h"

t_conv	*ft_lstnew(long *temp)
{
	t_conv	*new;

	new = (t_conv *)malloc(sizeof(t_conv));
	if (!new)
		return (NULL);
	new -> dest = temp[0];
	new -> source = temp[1];
	new -> range = temp[2];
	new -> next = NULL;
	return (new);
}

void	ft_lstadd_back(t_conv **lst, t_conv *new)
{
	t_conv	*tmp;

	if (*lst == NULL)
	{
		*lst = new;
		return ;
	}
	tmp = *lst;
	while (tmp -> next)
		tmp = tmp -> next;
	tmp -> next = new;
}
