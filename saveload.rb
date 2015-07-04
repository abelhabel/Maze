def load_level(level = 0)
  file_name = "./data/levels/level#{level}.txt"
  if File.exist?(file_name)
    file = File.open(file_name)
    content = file.read
  else
    return false
  end

  def objectify(str)
    arr = []
    str.each_line{|line| arr << line.split(' ')}
    arr
  end
  objectify(content)
end