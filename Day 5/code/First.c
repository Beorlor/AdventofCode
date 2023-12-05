#include "First.h"

void	print_seed(long *seed)
{
	int	i = 0;
	while (seed[i] != -1)
	{
		printf("%ld\n", seed[i]);
		i++;
	}
	free(seed);
}

long	*get_seed(int fd)
{
	long *seed;
	char *line;

	line = get_next_line(fd);
	seed = ft_split_number(line);
	free(line);
}

void	get_conversion_unit(t_conv **converter, int fd)
{
	char *line;
	long *temp;

	while ((line = get_next_line(fd)) != NULL)
	{
		temp = ft_split_number(line);

		free(temp);
		free(line);
	}
}

int main(void)
{
	int fd;
	const char *filename = "../input.txt";
	long *seed;
	t_conv **converter;

	fd = open(filename, O_RDONLY);
	//Get the seed first
	seed = get_seed(fd);
	//Get the converting value
	//array of chain list, cause we know how many converter we have (7), but not
	//how many pair value they will have
	converter = (t_conv **)malloc(sizeof(t_conv *) * 8);
	if (!converter)
	{
		printf("malloc failed");
		return (1);
	}
	converter[7] = NULL;
	get_conversion_unit(converter, fd);
	print_seed(seed);
	close(fd);
	return 0;
}
