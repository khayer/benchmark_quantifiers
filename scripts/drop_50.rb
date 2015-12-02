# In: Sam File (sorted by read name; fwd 1rst rev 2nd)
# Trimmed Reads by 50 bases
DROP = 50

def trim_back(sam_line)
  fields = sam_line.split("\t")
  # Trim sequence
  desired_length = fields[9].length - DROP
  fields[9] = fields[9][0...desired_length]

  # Trim Cigar
  # 5M3987N90M2282N52M4697N3M
  numbers = (fields[5].split(/\D/) - [""]).map { |e| e.to_i }
  letters = fields[5].split(/\d*/) - [""]
  num = 0
  new_cigar = ""
  letters.each_with_index do |l,i|
    case l
    when "M" || "I"
      if num < desired_length
        if numbers[i] + num > desired_length
          current = desired_length - num
          new_cigar += "#{current}#{l}"
          num += current
        else
          new_cigar += "#{numbers[i]}#{l}"
          num += numbers[i]
        end
      end
      #puts new_cigar
      #exit
    when "N" || "D"
      new_cigar += "#{numbers[i]}#{l}"
    end
  end
  if new_cigar =~ /N$/ || new_cigar =~ /D$/
    numbers = (new_cigar.split(/\D/) - [""]).map { |e| e.to_i }
    letters = new_cigar.split(/\d*/) - [""]
    stop = letters.length - 1
    new_cigar = ""
    letters.each_with_index do |l,i|
      break if i == stop
      new_cigar += "#{numbers[i]}#{l}"
    end
  end
  fields[5] = new_cigar
  fields.join("\t")
end


def trim_front(sam_line)
  fields = sam_line.split("\t")
  # Trim sequence
  desired_length = fields[9].length - DROP
  fields[9] = fields[9][(DROP-1)...-1]

  # Trim Cigar
  # 5M3987N90M2282N52M4697N3M
  numbers = (fields[5].split(/\D/) - [""]).map { |e| e.to_i }
  letters = fields[5].split(/\d*/) - [""]
  num = 0
  new_cigar = ""
  letters.reverse!
  numbers.reverse!
  letters.each_with_index do |l,i|
    case l
    when "M" || "I" || "S" || "H"
      if num < desired_length
        if numbers[i] + num > desired_length
          current = desired_length - num
          new_cigar = "#{current}#{l}#{new_cigar}"
          num += current
        else
          new_cigar = "#{numbers[i]}#{l}#{new_cigar}"
          num += numbers[i]
        end
      end
      #puts new_cigar
      #exit
    when "N" || "D"
      new_cigar = "#{numbers[i]}#{l}#{new_cigar}"
    end
  end
  if new_cigar =~ /^\d*N/ || new_cigar =~ /^\d*D/
    numbers = (new_cigar.split(/\D/) - [""]).map { |e| e.to_i }
    letters = new_cigar.split(/\d*/) - [""]
    new_cigar = ""
    letters.each_with_index do |l,i|
      next if i == 0
      new_cigar += "#{numbers[i]}#{l}"
    end
  end
  fields[5] = new_cigar
  fields.join("\t")
end

first = true
File.open(ARGV[0]).each do |line|
  line.chomp!
  if line =~ /^@/
    puts line
    next
  end
  if first
    puts trim_back(line)
    first = false
  else
    puts trim_front(line)
    first = true

  end
  #exit
end
