-- Function to parse cards from a string
local function parseCards(input)
    local cards = {}
    for line in input:gmatch("[^\r\n]+") do
        local winning, player = line:match(":%s*(.-)%s*|%s*(.*)")
        local card = {
            winning = {},
            player = {}
        }
        for number in winning:gmatch("%d+") do
            table.insert(card.winning, tonumber(number))
        end
        for number in player:gmatch("%d+") do
            table.insert(card.player, tonumber(number))
        end
        table.insert(cards, card)
    end
    return cards
end

-- Function to calculate points for a card
local function calculateCardPoints(card)
    local matches = 0
    for _, pNum in ipairs(card.player) do
        for _, wNum in ipairs(card.winning) do
            if pNum == wNum then
                matches = matches + 1
                break
            end
        end
    end
    return matches > 0 and math.pow(2, matches - 1) or 0
end

-- Reading the input from a file
local file = io.open("input.txt", "r")
if not file then
    print("Error: Could not open input.txt")
    return
end
local input = file:read("*all")
file:close()

-- Calculate total points
local cards = parseCards(input)
local totalPoints = 0
for _, card in ipairs(cards) do
    totalPoints = totalPoints + calculateCardPoints(card)
end

print("Total Points:", totalPoints)
