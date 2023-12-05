#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

static int	is_sep(char c)
{
	if (c >= '0' && c <= '9')
		return (0);
	else
		return (1);
}

static int	ft_count_numbers(char const *s)
{
	int	word_count;

	word_count = 0;
	while (*s)
	{
		while (is_sep(*s))
			s++;
		if (*s)
		{
			word_count++;
			printf("%c\n", *s);
		}
		while (!is_sep(*s))
			s++;
	}
	return (word_count);
}

int	main(void)
{
	printf("%d", ft_count_numbers("s"));
}
