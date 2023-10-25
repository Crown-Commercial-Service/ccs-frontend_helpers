class String
  def to_one_line
    gsub(/\s{2,}/, '').gsub("\n", '')
  end
end
