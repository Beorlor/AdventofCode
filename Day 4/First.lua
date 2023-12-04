function parse_cards(cards_data)
    local cards = {}
    for line in cards_data:gmatch("[^\r\n]+") do
        local winning_numbers_str, player_numbers_str = line:match("Card %d+: (.+) %| (.+)")
        local winning_numbers = {}
        for number in winning_numbers_str:gmatch("%d+") do
            table.insert(winning_numbers, tonumber(number))
        end

        local player_numbers = {}
        for number in player_numbers_str:gmatch("%d+") do
            table.insert(player_numbers, tonumber(number))
        end

        table.insert(cards, {winning = winning_numbers, player = player_numbers})
    end
    return cards
end

function calculate_card_points(card)
    local matches = 0
    for _, num in ipairs(card.player) do
        for _, win_num in ipairs(card.winning) do
            if num == win_num then
                matches = matches + 1
            end
        end
    end
    return matches > 0 and 2 ^ (matches - 1) or 0
end

-- Read cards data from input.txt
local file = io.open("input.txt", "r")
if not file then
    print("Failed to open input.txt")
    return
end

local cards_data = file:read("*all")
file:close()

-- Process the cards and calculate the total points
local cards = parse_cards(cards_data)
local total_points = 0
for _, card in ipairs(cards) do
    total_points = total_points + calculate_card_points(card)
end

print("Total Points:", total_points)
