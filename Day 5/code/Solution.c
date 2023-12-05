#include "Solution.h"

// PARSING /////////////////////////////////////////////////////////////////////

long	*get_seed(int fd)
{
	long *seed;
	char *line;

	line = get_next_line(fd);
	seed = ft_split_number(line);
	free(line);
	return (seed);
}

int	is_next_converter(char *s)
{
	int i = 0;
	char *str[] = {"seed-to-soil", "soil-to-fertilizer", "fertilizer-to-water",
	"water-to-light", "light-to-temperature", "temperature-to-humidity", "humidity-to-location"};
	while (i < 7)
	{
		if (ft_strncmp(s, str[i], 10) == 0)
			return (1);
		i++;
	}
	return (0);
}

void	get_conversion_unit(t_conv **converter, int fd)
{
	char *line;
	long *temp;
	int index = -1;

	while ((line = get_next_line(fd)) != NULL)
	{
		if (line[0] == '\n')
		{
			free(line);
			continue ;
		}
		if (is_next_converter(line))
		{
			index++;
			free(line);
			continue ;
		}
		temp = ft_split_number(line);
		ft_lstadd_back(&converter[index], ft_lstnew(temp));
		free(temp);
		free(line);
	}
}

// LOGIC ///////////////////////////////////////////////////////////////////////

long find_location(long seed, t_conv** converter)
{
	long actual = seed;
	int i = 0;
	t_conv *temp;

	while (converter[i])
	{
		temp = converter[i];
		while (temp)
		{
			if (seed >= temp->source && seed < temp->source + temp->range)
			{
				actual = seed - temp->source + temp->dest;
				break;
			}
			temp = temp->next;
		}
		seed = actual;
		i++;
	}
	return actual;
}

long	solving_first(long *seed, t_conv **converter)
{
	int	i = 0;
	long	lowest_location = LONG_MAX;
	long	temp_location = 0;

	while (seed[i] != -1)
	{
		temp_location = find_location(seed[i], converter);
		if (temp_location < lowest_location)
			lowest_location = temp_location;
		i++;
	}
	return (lowest_location);
}

long	solving_second(long *seed, t_conv **converter)
{
	int	i = 0;
	long	lowest_location = LONG_MAX;
	long	temp_location = 0;
	int	actual = seed[0];

	while (seed[i] != -1)
	{
		while (actual < (seed[i] + seed[i+1]))
		{
			temp_location = find_location(actual, converter);
			if (temp_location < lowest_location)
				lowest_location = temp_location;
			actual++;
		}
		i++;
		if (seed[i] != -1)
			i++;
	}
	return (lowest_location);
}

// MAIN ////////////////////////////////////////////////////////////////////////

void free_all(long *seed, t_conv **converter)
{
	int i = 0;
	t_conv *temp;
	t_conv *save;

	while (converter && converter[i])
	{
		temp = converter[i];
		while (temp)
		{
			save = temp->next;
			free(temp);
			temp = save;
		}
		i++;
	}
	free(converter);
	if (seed)
		free(seed);
}


int main(void)
{
	int fd;
	const char *filename = "../input.txt";
	long *seed;
	t_conv **converter;

	fd = open(filename, O_RDONLY);
	//array of chain list, cause we know how many converter we have (7), but not
	//how many pair value they will have
    converter = (t_conv **)malloc(sizeof(t_conv *) * 8);
    if (!converter) {
        printf("malloc failed");
        return (1);
    }
    for (int i = 0; i < 8; i++) {
        converter[i] = NULL;
    }
    seed = get_seed(fd);
    get_conversion_unit(converter, fd);
	printf("RESULT FIRST: %ld\n", solving_first(seed, converter));
	printf("RESULT SECOND: %ld\n", solving_second(seed, converter));
	free_all(seed, converter);
	close(fd);
	return (0);
}
