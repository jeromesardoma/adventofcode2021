input = "8826876714
3127787238
8182852861
4655371483
3864551365
1878253581
8317422437
1517254266
2621124761
3473331514"

ROWS = input.split("\n").map do |str|
  str.chars.map(&:to_i)
end

def increment_adjacents(row_i, col_i)
  ((row_i - 1)..(row_i + 1)).each do |r|
    ((col_i - 1)..(col_i + 1)).each do |c|
      if ( (r == row_i && c == col_i) || 
        ROWS[r].nil? ||
        ROWS[r][c].nil? || 
        ROWS[r][c] == "F" ||
        r == -1 ||
        c == -1 )
        next
      end
      ROWS[r][c] += 1
    end
  end
end

def mark_flash_at(row_i, col_i)
  ROWS[row_i][col_i] = 'F'
end

def reset_at(row_i, col_i)
  ROWS[row_i][col_i] = 0
end

def increment_octos
  (0...ROWS.length).each do |ri|
    (0...ROWS.first.length).each do |ci|
      ROWS[ri][ci] += 1
    end
  end
end

def flash_octos
  (0...ROWS.length).each do |ri|
    (0...ROWS.first.length).each do |ci|
      next if ROWS[ri][ci] == 'F'
      if ROWS[ri][ci] > 9
        increment_adjacents(ri, ci)
        mark_flash_at ri, ci
      end
    end
  end
end

def count_flashes
  ROWS.flatten.count { |octo| octo == 'F' }
end

def reset_flashes
  (0...ROWS.length).each do |ri|
    (0...ROWS.first.length).each do |ci|   
      reset_at ri, ci if ROWS[ri][ci] == "F"
    end
  end
end

def flashes_remain?
  ROWS.flatten.each do |octo|
    next if octo == 'F'
    return true if octo > 9
  end
  false
end

def synchronized?
  ROWS.flatten.all?(&:zero?)
end

# 1. increment all octos by 1
#   if octo > 9, flash adjacent cells to octo
#   ** an octo can only flash once per turn
#     then reset flashed octo value to 0

flash_count = 0

# part 1

# 100.times do
#   increment_octos
#   loop do
#     flash_octos
#     break unless flashes_remain?
#   end
#   flash_count += count_flashes
#   reset_flashes
# end

# ROWS.each { |r| p r }
# p flash_count

# part 2

counter = 0

loop do
  increment_octos
  loop do
    flash_octos
    break unless flashes_remain?
  end
  flash_count += count_flashes
  reset_flashes
  counter += 1
  break if synchronized?
end

ROWS.each { |r| p r }
p counter







