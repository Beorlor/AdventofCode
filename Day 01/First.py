def extract_digits_with_words(line):
	return ''.join(filter(str.isdigit, line))

def sum_calibration_values_with_words(text):
	total_sum = 0
	lines = text.split('\n')
	for line in lines:
		line = line.strip()
		if not line:
			continue

		digits = extract_digits_with_words(line)
		first_digit = digits[0]
		last_digit = digits[-1]
		calibration_value = int(first_digit + last_digit)
		total_sum += calibration_value

	return total_sum

# Read input from input.txt
with open('input.txt', 'r') as file:
	input_text = file.read()

# Calculate the sum for the second part of the puzzle
sum_with_words = sum_calibration_values_with_words(input_text)
print("Sum for the second part:", sum_with_words)
