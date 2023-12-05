#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>

//if a char is a space return 1
static int	ft_isspace(char c)
{
	return (c == ' ' || c == '\f' || c == '\n' || c == '\r'
		|| c == '\t' || c == '\v');
}

//tranform string to long
static long	ft_atoi(const char *nptr)
{
	int	i;
	long		sign;
	long	res;

	i = 0;
	res = 0;
	sign = 1;
	while (ft_isspace(nptr[i]))
		++i;
	if (nptr[i] == '-' || nptr[i] == '+')
	{
		if (nptr[i] == '-')
			sign = -1;
		++i;
	}
	while ('0' <= nptr[i] && nptr[i] <= '9')
	{
		res = res * 10 + (nptr[i] - '0');
		++i;
	}
	return (sign * res);
}

//if a char is 0-9 return 0 else return 1
static int	is_sep(char c)
{
	if (c >= '0' && c <= '9')
		return (0);
	else
		return (1);
}

//count how many numbers there is
static int	ft_count_numbers(char const *s)
{
	int	word_numb;

	word_numb = 0;
	while (*s)
	{
		while (*s && is_sep(*s))
			s++;
		if (*s)
		{
			word_numb++;
		}
		while (!is_sep(*s))
			s++;
	}
	return (word_numb);
}

//put the number into arr_number
static void	write_numb(long	*arr_number, const char *str)
{
	int	num_count = 0;

	while (*str)
	{
		while (*str && is_sep(*str))
			str++;
		if (*str)
		{
			arr_number[num_count] = ft_atoi(str);
			num_count++;
		}
		while (*str && !is_sep(*str))
			str++;
	}
}

// the main function of split (-1 at the end of the array)
long	*ft_split_number(char *str)
{
	long	*arr_number;
	int		num_count;

	num_count = ft_count_numbers(str);
	arr_number = (long *)malloc(sizeof(long) * (num_count + 1));
	arr_number[num_count] = -1;
	write_numb(arr_number, str);
	return (arr_number);
}
