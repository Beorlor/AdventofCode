-- Function to parse cards from a string
local function parseCards(input)
    local cards = {}
    for line in input:gmatch("[^\r\n]+") do
        local winning, player = line:match(":%s*(.-)%s*|%s*(.*)")
        local card = {
            winning = {},
            player = {},
            instances = 1 -- Add instances field to keep track of the number of instances
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

-- Function to find the index of an element in a table
local function indexOf(table, element)
    for index, value in ipairs(table) do
        if value == element then
            return index
        end
    end
    return nil
end

-- Function to calculate the number of scratchcards won
local function calculateTotalScratchcards(cards)
    local totalScratchcards = 0
    local processed = {} -- Keep track of processed cards to avoid duplicates

    -- Recursive function to process the cards and their copies
    local function processCard(card)
        if not processed[card] then
            processed[card] = true
            local matches = 0
            for _, otherCard in ipairs(cards) do
                if otherCard ~= card then
                    for _, number in ipairs(otherCard.winning) do
                        if indexOf(card.player, number) then
                            matches = matches + 1
                            break
                        end
                    end
                end
            end
            for i = 1, matches do
                local copy = {
                    winning = card.winning,
                    player = card.player,
                    instances = 1
                }
                table.insert(cards, copy)
            end
            totalScratchcards = totalScratchcards + card.instances
        end
    end

    -- Process each card
    for _, card in ipairs(cards) do
        processCard(card)
    end

    return totalScratchcards
end

-- Reading the input from a file
local file = io.open("input.txt", "r")
if not file then
    print("Error: Could not open input.txt")
    return
end
local input = file:read("*all")
file:close()

-- Calculate total scratchcards
local cards = parseCards(input)
local totalScratchcards = calculateTotalScratchcards(cards)
print("Total Scratchcards:", totalScratchcards)
