def extract_digits_with_words(line):
	words_to_digits = {
		'one': '1', 'two': '2', 'three': '3', 'four': '4',
		'five': '5', 'six': '6', 'seven': '7', 'eight': '8', 'nine': '9'
	}
	digits = []
	i = 0
	while i < len(line):
		found_word = False
		# Check if the current segment forms a number word
		for word, digit in words_to_digits.items():
			if line[i:].startswith(word):
				digits.append(digit)
				found_word = True
				break  # Stop checking other words

		if not found_word and line[i].isdigit():
			digits.append(line[i])

		i += 1  # Move to the next character

	return ''.join(digits)

def sum_calibration_values_with_words(text):
	total_sum = 0
	lines = text.split('\n')
	for line in lines:
		line = line.strip()
		if not line:
			continue

		digits = extract_digits_with_words(line)
		if digits:
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
