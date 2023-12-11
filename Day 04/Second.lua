-- Function to parse cards from a string
local function parseCards(input)
    local cards = {}
    for line in input:gmatch("[^\r\n]+") do
        local winning, player = line:match(":%s*(.-)%s*|%s*(.*)")
        local card = {
            winning = {},
            player = {},
            instances = 1, -- Track the number of instances
            matches = 0    -- Initialize the number of matching numbers
        }
        for number in winning:gmatch("%d+") do
            card.winning[tonumber(number)] = true -- Use a table for efficient lookup
        end
        for number in player:gmatch("%d+") do
            table.insert(card.player, tonumber(number))
        end
        table.insert(cards, card)
    end
    return cards
end

-- Function to count and update matching numbers for each card
local function countMatches(cards)
    for _, card in ipairs(cards) do
        for _, number in ipairs(card.player) do
            if card.winning[number] then
                card.matches = card.matches + 1
            end
        end
    end
end

-- Process the cards to calculate total scratchcards
local function processCards(cards)
    local total = 0
    for i = 1, #cards do
        local card = cards[i]
        total = total + card.instances
        if i < #cards and card.matches > 0 then
            for j = i + 1, math.min(i + card.matches, #cards) do
                cards[j].instances = cards[j].instances + card.instances
            end
        end
    end
    return total
end

--[[ Reading the input from a file
local file = io.open("input.txt", "r")
if not file then
    print("Error: Could not open input.txt")
    return
end
local input = file:read("*all")
file:close()]]

local input = [[
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
]]

-- Calculate total scratchcards
local cards = parseCards(input)


--[[ print cards on screen
for index, card in ipairs(cards) do
	print("Card", index)
	print("Winning:", table.concat(card.winning, ", "))
	print("Player:", table.concat(card.player, ", "))
	print("Instances:", card.instances)
	print()
end]]

countMatches(cards) -- Update the matches for each card
local totalScratchcards = processCards(cards)
print("Total Scratchcards:", totalScratchcards)
