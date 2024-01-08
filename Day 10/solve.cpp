#include <vector>
#include <map>
#include <iostream>
#include <fstream>

enum Direction
{
  None = 0,
  Up = 1,
  Down = 2,
  Left = 4,
  Right = 8
};

std::map<char, int> direction = { { '|', Up | Down },     //
                                  { '-', Left | Right },  //
                                  { 'L', Up | Right },    //
                                  { 'J', Up | Left },     //
                                  { '7', Down | Left },   //
                                  { 'F', Down | Right },  //
                                  { '.', None },          //
                                  { 'S', Up | Down | Left | Right } };

std::vector<std::string> load()
{
  std::vector<std::string> data;
  std::ifstream file("input");
  for (std::string line; std::getline(file, line);)
    data.push_back(line);
  return data;
}

int main()
{
  auto data = load();
  int r = data[1].size() - 1, u = data.size() - 1;

  int sx, x, sy, y;
  for (uint k = 0; k < data.size(); k++)
    for (uint i = 0; i < data[k].size(); i++)
      if (data[k][i] == 'S')
        sx = x = k, sy = y = i;

  int area{}, circ{};
  while (++circ)
  {
    auto& c = data[x][y];
    if (y < r && direction[c] & Right && direction[data[x][y + 1]] & Left)
      area += x, y++;
    else if (x < u && direction[c] & Down && direction[data[x + 1][y]] & Up)
      area -= y, x++;
    else if (y > 0 && direction[c] & Left && direction[data[x][y - 1]] & Right)
      area -= x, y--;
    else if (x > 0 && direction[c] & Up && direction[data[x - 1][y]] & Down)
      area += y, x--;
    else
      break;
    c = '.';
  }
  area += x * sy - y * sx;

  std::cout << "Part 1: " << circ / 2 << '\n';
  std::cout << "Part 2: " << (std::abs(area) - circ) / 2 + 1 << '\n';
}