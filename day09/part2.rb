msg = $stdin.readlines.map(&:to_i)
D = 25
T = 32321523

(2..msg.length).each do |len|
  (0...msg.length-len).each do |start|
    run = msg[start, len]
    if run.sum == T
      puts run.min + run.max
      exit
    end
  end
end
